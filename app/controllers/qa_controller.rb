class QaController < ApplicationController

  def qa
    @qaFile = File.read('app/views/qa/qa.html.erb')

    respond_to do |format|
      format.html
      format.text do
        render plain: @qaFile
      end
    end
  end

  def editQA
    @qaFile = File.read('app/views/qa/qa.html.erb')
  end

  def applyQA

  end

end
