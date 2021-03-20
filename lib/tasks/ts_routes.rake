# frozen_string_literal: true

TS_ROUTES_FILENAME = 'app/javascript/generated/routes.ts'

namespace :ts do
  desc "Generate #{TS_ROUTES_FILENAME}"
  task :routes => :environment do
    Rails.logger.info("Generating #{TS_ROUTES_FILENAME}")
    source = TsRoutes.generate(:exclude => [/admin/, /debug/])

    dirname = File.dirname(TS_ROUTES_FILENAME)
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

    out_file = File.new(TS_ROUTES_FILENAME, 'w')
    out_file.write(source)
    out_file.close
  end
end
