# Basic rate limiting for the public API. Limits are generous for real
# players but blunt brute-force probing of character coordinates and
# leaderboard spam.
class Rack::Attack
  # Overall API budget per client.
  throttle("api/ip", limit: 300, period: 5.minutes) do |req|
    req.ip if req.path.start_with?("/api/")
  end

  # Starting games is much rarer than checking guesses.
  throttle("timers/create/ip", limit: 30, period: 5.minutes) do |req|
    req.ip if req.path == "/api/timers" && req.post?
  end

  self.throttled_responder = lambda do |_request|
    [ 429, { "Content-Type" => "application/json" }, [ { error: "Too many requests. Slow down and try again shortly." }.to_json ] ]
  end
end

Rack::Attack.enabled = !Rails.env.test?
