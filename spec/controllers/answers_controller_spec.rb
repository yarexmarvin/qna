require "rails_helper"

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe "GET #show" do
    before { get :show, params: { id: answer } }

    it "assigns the requested to answer to @answer" do
      expect(assigns(:answer)).to eq answer
    end

    it "should render show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { get :new, params: { question_id: question } }

    it "assigns a new Answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "should render new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves a new answer in database" do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it "redirects to show view" do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }

        expect(response).to redirect_to assigns(:answer)
      end
    end

    context "with invalid attributes" do
      it "does not save a new answer in database" do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.to_not change(question.answers, :count)
      end

      it "re-renders new view" do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }

        expect(response).to render_template :new
      end
    end
  end
end
