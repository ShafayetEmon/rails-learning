module QuotesHelper
  def query_highlight
    params[:search].to_s.split(' ')
  end
end
