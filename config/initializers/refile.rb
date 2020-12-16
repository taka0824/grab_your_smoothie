Refile::MiniMagick.prepend Module.new {
  [:limit, :fit, :fill, :pad].each do |action|
    define_method(action) do |img, *args|
      super(img, *args) { |cmd| cmd.auto_orient }
    end
  end
}
# image auto orientationの機能
Refile.backends['store'] = Refile::Backend::FileSystem.new('public/uploads/')