class MaterialsController < ApplicationController
  def index
    @materials = ProvidedMaterial.all
    @providers = Provider.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def addof
    if params[:material]
      ProvidedMaterial.create(name: params[:material][:name], material: params[:material][:material], unit: params[:material][:unit], ppu: params[:material][:ppu].to_f)
    end
  end

  def remof
    ProvidedMaterial.find_by(id: params[:id]).destroy
  end

  def addprov
    if params[:material]
      Provider.create(name: params[:material][:name])
    end
  end

  def remprov
    Provider.find_by(id: params[:id]).destroy
  end
end
