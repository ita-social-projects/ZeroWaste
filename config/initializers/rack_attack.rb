class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  def self.token_from_header(req)
    if req.env["HTTP_AUTHORIZATION"].to_s.start_with?("Bearer ")
      req.env["HTTP_AUTHORIZATION"].to_s.sub(/^Bearer\s+/, "")
    end
  end

  throttle("api/token", limit: 5, period: 60.seconds) do |req|
    next unless req.path.match?(%r{^/[a-z]{2}/api/v2/})
    next unless req.get? || req.post?

    token_from_header(req)
  end

  Rack::Attack.throttled_responder = lambda do |request|
    retry_after = (request.env["rack.attack.match_data"] || {})[:period]
    [
      429,
      { "Content-Type" => "application/json", "Retry-After" => retry_after.to_s },
      [{ error: "Rate limit exceeded. Try again in #{retry_after} seconds." }.to_json]
    ]
  end
end
