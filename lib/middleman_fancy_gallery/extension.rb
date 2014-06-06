

module MiddlemanFancyGallery
  class Extension < Middleman::Extension
    option :galleries, {}, 'Galleries specification'

    def initialize(app, options_hash={}, &block)
      puts '-- Registering FancyGallery extension'
      super

      app.include MiddlemanMethods

      app.after_configuration do
        # import fancybox assets (js, css, support images)
        assets_path = File.expand_path('../../../vendor/assets', __FILE__)
        Dir["#{assets_path}/**/*"].each do |file|
          if File.file? file
            sprockets.import_asset File.basename(file)
          end
        end

        options_hash[:galleries].each_pair do |gallery_name, gallery_options|
          ThumbnailsGenerator.new(gallery_name, gallery_options).generate_images
        end

      end
    end


    helpers do
      def fancy_gallery(name)
        gallery_name = name.to_s
        src_dir = File.join root, 'source', 'images', gallery_name
        concat "<div class='gallery-wrapper #{gallery_name}'>"
        Dir.glob("#{src_dir}/**/thumb-*.{jpg,png}", File::FNM_CASEFOLD).each do |file|
          base_name = File.basename file
          thumbnail_url = "#{gallery_name}/#{base_name}"
          image_url = "images/#{gallery_name}/#{base_name.gsub(/^thumb-/, '')}"
          concat link_to(image_tag(thumbnail_url), image_url, class: 'fancybox gallery-item', rel: gallery_name)
        end
        concat '</div>'
      end

      def fancy_script
        <<TEXT
<script type="text/javascript">
	$(document).ready(function() {
		$(".fancybox").fancybox();
	});
</script>
TEXT
      end

      def include_fancy_assets
        concat fancy_javascript_assets('jquery-*')
        concat fancy_javascript_assets('jquery.mousewheel-*')
        concat fancy_javascript_assets('jquery.fancybox*')
        concat fancy_stylesheet_assets('jquery.fancybox*')
      end

      def fancy_javascript_assets(pattern)
        assets_path = File.expand_path("../../../vendor/assets/javascripts/#{pattern}", __FILE__)
        Dir[assets_path].map{|f| javascript_include_tag File.basename(f)}.join
      end

      def fancy_stylesheet_assets(pattern)
        assets_path = File.expand_path("../../../vendor/assets/stylesheets/#{pattern}", __FILE__)
        Dir[assets_path].map{|f| stylesheet_link_tag File.basename(f)}.join
      end



    end

    module MiddlemanMethods
      # methods are available in middleman's config.rb
      def some_method

      end
    end


  end
end

::Middleman::Extensions.register(:fancy_gallery, MiddlemanFancyGallery::Extension)
