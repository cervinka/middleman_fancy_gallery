module MiddlemanFancyGallery

  # generate gallery images from images dir (outside middleman's 'source' dir) to 'source/images/gallery/<gallery_name>'
  class ThumbnailsGenerator
    def initialize(gallery_name, gallery_options)
      raise 'Please activate fancy_gallery with options (see !' if gallery_options.empty?
      @name = gallery_name.to_s
      @options = gallery_options

    end

    def generate_images
      dst_dir = File.join 'source', 'images', @name
      FileUtils.mkdir_p dst_dir
      src_dir = File.expand_path(@options[:source_dir])
      files = Dir.glob("#{src_dir}/**/*.{jpg,png}", File::FNM_CASEFOLD)
      print "Generating #{files.size} images in gallery '#{@name}': "
      files.each do |src_file_path|
        file_name = File.basename(src_file_path).downcase
        @original = nil
        @flag = '.'
        write_image(src_file_path, @options[:thumbnail_size], File.join(dst_dir, "thumb-#{file_name}"))
        write_image(src_file_path, @options[:image_size], File.join(dst_dir, file_name))
        print @flag
      end
      puts
    end


    def write_image(src_file_path, size, path)
      unless File.file? path
        @flag = '*'
        @original = load_image(src_file_path)
        target = @original.resize_to_fit(size, size)
        target.write (path) { self.quality = 65 }
      end
    end

    def load_image(file_path)
      @original = Magick::Image::read(file_path).first
    end

  end
end
