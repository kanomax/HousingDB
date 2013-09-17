class AgentsController < ApplicationController
  def new
     @agent = Agent.new
  end
  def create
    @agent = Agent.new(params[:agent])

    respond_to do |format|
      if @agent.save
        format.html { redirect_to @agent, notice: 'House was successfully created.' }
        format.json { render json: @agent, status: :created, location: @agent}
      else
        format.html { render action: "new" }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  @agent = Agent.find(params[:id])
  end
  
  def index
        @search = Agent.search(params[:q])
    @agents = @search.result
  end
  def show
    @agent = Agent.find(params[:id])
  end
end
