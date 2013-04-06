require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  setup do
    @dummy_model = Class.new do
      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ApiPartialPath # resonanz helper to force .json format and api/ subfolder

      def self.model_name
        @_model_name ||= ActiveModel::Name.new(self, nil, 'Dummy')
      end

      def persisted?
        false
      end
    end

    @views_folder = File.join(Dir.tmpdir, 'test_views')
    FileUtils.mkdir_p(File.join(@views_folder, 'api'))

    @controller.prepend_view_path(@views_folder)
  end

  teardown do
    FileUtils.rm_r(@views_folder, force: true)
  end

  test '#render_for_api renders single model' do
    template = File.join(@views_folder, 'api/_dummy.json.jbuilder')
    File.open(template, 'w') { |file| file.write('json.test "test"') }

    assert_equal '{"test":"test"}', @controller.render_for_api(@dummy_model.new)
  end

  test '#render_for_api renders array of models' do
    template = File.join(@views_folder, 'api/_dummy.json.jbuilder')
    File.open(template, 'w') { |file| file.write('json.test "test"') }

    assert_equal '[{"test":"test"}]', @controller.render_for_api([@dummy_model.new])
  end

  test '#render_for_api renders array of models with collection partial' do
    template = File.join(@views_folder, 'api/_dummies.json.jbuilder')
    File.open(template, 'w') { |file| file.write('json.array!(dummies) {json.test "test"}') }

    assert_equal '[{"test":"test"}]', @controller.render_for_api([@dummy_model.new])
  end

end