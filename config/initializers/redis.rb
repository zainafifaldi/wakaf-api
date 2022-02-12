# frozen_string_literal: true

Redis.new(url:  ENV['REDIS_URL'],
          port: ENV['REDIS_PORT'],
          db:   ENV['REDIS_DB'])
