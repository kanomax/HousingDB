class AgentsController < ApplicationController
 def new
    @agent = Agent.new
 end

 def create
   ad_params = params.require(:agent).permit!
    @agent = Agent.new(ad_params)

   respond_to do |format|
     if @agent.save
       format.html { redirect_to @agent, notice: 'Agent was successfully created.' }
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
  
 def update
    @agent = Agent.find(params[:id])

    respond_to do |format|
      ad_params = params.require(:agent).permit!
      if @agent.update_attributes(ad_params)
        format.html { redirect_to @agent, notice: 'Agent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @agent = Agent.find(params[:id])
    @agent.destroy

    respond_to do |format|
      format.html { redirect_to(agents_path) }
      format.json { head :no_content }
    end
  end
end
