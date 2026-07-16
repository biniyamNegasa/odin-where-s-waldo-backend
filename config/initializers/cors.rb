# Allow cross-origin requests from the frontend in every environment.
# Configure production origins via the FRONTEND_ORIGINS env var
# (comma-separated, e.g. "https://my-app.netlify.app").
allowed_origins = ENV.fetch("FRONTEND_ORIGINS", "http://localhost:5173,http://localhost:4173")
                     .split(",").map(&:strip)

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(*allowed_origins)

    resource "/api/*",
      headers: :any,
      methods: %i[get post patch options head]
  end
end
