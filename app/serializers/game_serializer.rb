class GameSerializer < ActiveModel::Serializer
  attributes :id, :rows, :cols, :mines, :board
end
