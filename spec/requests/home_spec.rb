require 'rails_helper'

RSpec.describe 'HomeController', type: :request do
  describe 'GET :index' do
    it 'is successful' do
      get root_path

      expect(response.body).to include('The calculator tells you how many')

      expect(response).to render_template(:index)
      expect(response).to be_successful
    end

    context 'with default locale' do
      it 'is successful' do
        get root_path

        expect(root_path).to eq('/en')
        expect(response.body).to include('Welcome to the diaper calculator')

        expect(response).to render_template(:index)
        expect(response).to be_successful
      end
    end

    context 'with locale switching' do
      it 'is successful' do
        get root_path(locale: :uk)
        expect(response.body).to include('Вас вітає калькулятор підгузків')

        get root_path(locale: :en)
        expect(response.body).to include('Welcome to the diaper calculator')

        expect(response).to render_template(:index)
        expect(response).to be_successful
      end
    end
  end
end
