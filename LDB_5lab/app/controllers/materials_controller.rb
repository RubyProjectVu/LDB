class MaterialsController < ApplicationController
  def index
    @materials = ProvidedMaterial.all
    @providers = Provider.all
  end

  def addof
    if params.key?(:material)
      hash = params.fetch(:material)
      ProvidedMaterial.create(name: hash.fetch(:name), material: hash.fetch(:material), unit: hash.fetch(:unit), ppu: hash.fetch(:ppu))
    end
  end

  def remof
    ProvidedMaterial.find_by(id: params.fetch(:id)).destroy
  end

  def addprov
    if params.key?(:material)
      Provider.create(name: params.fetch(:material).fetch(:name))
    end
  end

  def remprov
    Provider.find_by(id: params.fetch(:id)).destroy
  end
end
