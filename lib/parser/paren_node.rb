class ParenNode < Treetop::Runtime::SyntaxNode
  def depth
    if terminal?
      0
    else
      nested_parens.depth + 1
    end
  end
end

