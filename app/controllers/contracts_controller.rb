class ContractsController < ApplicationController
  before_action :find_contract, only: [:edit, :update, :destroy]

  def index
    @contracts = current_user.role == "admin" ? Contract.all : current_user.contracts
  end

  def edit
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.create(contract_params)
    if @contract.save
      redirect_to contracts_url, notice: "Sucessfully created '#{@contract.name}'"
    else
      render 'edit'
    end
  end 

  def update
    if @contract.update(contract_params)
      redirect_to contracts_path(@contract), notice: "Sucessfully updated '#{@contract.name}'"
    else
      render 'edit'
    end
  end

  def destroy
    name = @contract.name
    @contract.destroy

    redirect_to contracts_url, notice: "Sucessfully deleted '#{name}'"
  end

  private

  def contract_params
    params.require(:contract).permit(:name)
  end

  def find_contract
    @contract = current_user.contracts.find(params[:contract_id] || params[:id])
  end

end
