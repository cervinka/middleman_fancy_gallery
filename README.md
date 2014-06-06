# MiddlemanFancyGallery

Add fancybox2 support for middleman. Generates thumbnail images, provides helpers for gallery generation.

## Installation

Add this line to your application's Gemfile:

    gem 'middleman_fancy_gallery', git: 

And then execute:

    $ bundle

## Usage

### Place images in directories under your project, but outside `source` directory. Recommended structure is:
 
```
your-middleman-project
  gallery-images
    gallery1
    gallery2
  source
  ...
```

If you have only one gallery, you can place images directly under `gallery-images`

### Register extension in `config.rb`
 
```ruby
require 'middleman_fancy_gallery'

activate :fancy_gallery,
         galleries: {
             gallery1: {                                   # gallery name - used in generated html code for distinguish between galleries
                 source_dir: 'gallery-images/gallery1',    # where are source images placed (relative to middleman root)
                 thumbnail_size: 200,                      # size of thumbnails (resize_to_fit(thumbnail_size, thumbnail_size))
                 image_size: 800                           # size of images in gallery (resize_to_fit(image_size, image_size))
             },
             gallery2: {
                 source_dir: 'gallery-images/gallery2',
                 thumbnail_size: 150,
                 image_size: 800
             },
         }
```

Thumbnail generation is time expensive operation, so images are only generated when middleman starts. When you add more images to gallery, you must restart middleman. Generated images are placed in `source/images/<<gallery_name>>`. Big images have the same filename as original ones, thumbnails have prefix `thumb-`. If target file already exists, generation is skipped (you will see `.` mark on startup), otherwise it's generated (mark `*`).   

### Generate gallery

**Include all needed javascripts and stylesheets** (all assets are registered in extension, but you can use your own if you want):

```erb
<%= include_fancy_assets %>
```

it's equivalent to:

```erb
<%= stylesheet_link_tag "jquery.fancybox" %>
<%= javascript_include_tag "jquery-1.10.1.min" %>
<%= javascript_include_tag "jquery.mousewheel-3.0.6.pack" %>
<%= javascript_include_tag "jquery.fancybox.pack" %>
```

**Generate html code for gallery images**
 
```erb
<%= fancy_gallery "gallery1" %>
<%= fancy_script %> 
```

`fancy_gallery` helper generates thumbnail images and links to big ones. Generated HTMl looks like:

```html
<div class="gallery-wrapper $$gallery_name$$">
  <a class="fancybox gallery-item" rel="$$gallery_name$$" href="/images/$$gallery_name$$/$$image_name$$">
    <img src="/images/$$gallery_name$$/thumb-$$image_name$$">
  </a>
  ...
</div>
```

`fancy_script` helper simply initializes fancybox (please use your own initializer if you want something more):

```html
<script type="text/javascript">
	$(document).ready(function() {
		$(".fancybox").fancybox();
	});
</script>
```  
 
 
## License

Please be aware that you need to purchase a [license](http://fancyapps.com/fancybox/#license) if you want to use fancybox2 for commercial purposes.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/middleman_fancy_gallery/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
