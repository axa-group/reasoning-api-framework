class StatementsController < ApplicationController
  before_action :find_contract, except: [:show]
  before_action :find_statement, only: [:edit, :update, :destroy, :diagram]

  # expose API
  skip_before_action :authenticate_user!, only: [:show]

  
  def index
    @statements = @contract.statements
  end

  def diagram
  end

  def new
    @statement = @contract.statements.build
  end

  def edit
  end

  def create
    @statement = Statement.new(statement_params)

    if @statement.save
      redirect_to contract_statements_url(@contract), notice: "Sucessfully saved the #{view_context.link_to('statement', edit_contract_statement_url(@contract, @statement))}", flash: { html_safe: true }
    else
      render 'edit', locals: {message: @statement.errors.full_messages.join(", ")}
    end
  end

  def update
    if @statement.update(statement_params)
      redirect_to edit_contract_statement_url(@contract, @statement), notice: "Sucessfully updated the statement"
    else
      flash.now[:alert] = "Error: #{@statement.errors.full_messages.join(", ")}"
      render 'edit' 
    end
  end

  def destroy
    name = @statement.name
    @statement.destroy
    redirect_to contract_statements_path(@contract), notice: "Sucessfully deleted statement '#{name}'"
  end

  # API endpoint
  def show
    @contract = Contract.find(params[:contract_id])
    @statement = @contract.statements.find(params[:id])

    respond_to do |format|
      format.json {
        # select all clouds which contain the values for the parameters provided in the query

        matching_clouds = @statement.entity_clouds.select{|ec| ec.entity_list.map(&:downcase).include?(params[ec.parameter].to_s.downcase)}
        matching_number_ranges = @statement.number_ranges.select{|nr| nr.includes?(params[nr.parameter])} 
        matching_date_ranges = @statement.date_ranges.select{|nr| nr.includes?((Date.parse(params[nr.parameter]) rescue nil))} 
        unconnected_response = @statement.responses.unconnected.first
        
        errors = nil
        
        # a path of one color exists for the parameters provided
        if (color = Connection::connected?(matching_clouds + matching_number_ranges + matching_date_ranges + @statement.responses))
          response = (@statement.response(color).try(:text) || true)
          code = 200
        # an unconnected fallback response exists
        elsif (fallback = unconnected_response.try(:text))
          response = fallback
          code = 200
        # handle incomplete request
        else
          missing_parameters = @statement.parameters - params.keys
          if missing_parameters.present?
            code = 400
            errors = {
              status: code, 
              source: {
                pointer: missing_parameters.first
              },
              title: "Missing parameter",
              detail: "Please provide the #{missing_parameters.first.humanize}"
            }
          else
            code = 422
            errors = {
              status: code,
              title: "Invalid parameter value",
              detail: "One or several parameter values could not be matched"
            }
          end
        end
         
        # render response
        render json: {response: response, errors: errors}.compact.to_json, status: code
      }
    end
  end

  def diagram
    render xml: @statement.diagram_xml
  end

  private

  def statement_params
    params.require(:statement).permit(:name, :contract_id, :diagram_xml, entity_clouds_attributes: [:id, :name, :parameter, :timestamp, :_destroy, {entity_list: []}], responses_attributes: [:id, :text, :timestamp, :_destroy], number_ranges_attributes: [:id, :number_from, :number_to, :timestamp, :parameter, :_destroy], date_ranges_attributes: [:id, :date_from, :date_to, :timestamp, :parameter, :_destroy])
  end

  def find_contract
    @contract = current_user.contracts.find(params[:contract_id] || params[:id])
  end

  def find_statement
    @statement = @contract.statements.find(params[:statement_id] || params[:id])
  end
end
