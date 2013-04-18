class SalesQuotePdf < Prawn::Document
  def initialize(quotation, view)
    super()
    @quotation = quotation
    @view = view
    
    define_grid(columns: 3, rows: 7, gutter: 0)
    #grid.show_all
    font_size 11
    
    grid([0,2],[0,2]).bounding_box do
      logo
    end
    
    grid([0,0],[0,1]).bounding_box do
      sales_quote_heading
    end
    grid([1,2],[2,2]).bounding_box do
      our_address
    end
    grid([1,0],[1,1]).bounding_box do
      address_box
    end
    # grid([2,0],[6,2]).bounding_box do
    #       quote_number_and_date
    #       quote_comment
    #       quote_table
    #       quote_total
    #       # payment_details     
    #     end
    quote_number_and_date
    quote_comment
    quote_table
    quote_total
    fold_mark
    sales_quote_page_number
    
    
  end
  
  def fold_mark
    repeat([1]) do         # only on first page
      transparent(0.5){stroke_horizontal_line -20, -10, at: 464 }
    end
  end
  
  def address_box
    text_box "#{@quotation.customer.name}
              #{@quotation.address.body}
              #{@quotation.address.post_code}"
        # at: [0,650],
        # width: 200,
        # height: 100,
        # align: :left 
  end
  
  def sales_quote_heading
    text "Sales Quotation", 
          size: 30, 
          style: :bold
  end
  
  def logo
    image "#{Rails.root}/app/assets/images/Sml_Blue_logo.jpg",
      position: :right
  end
  
  def our_address
    text_box "#{@quotation.supplier.addresses.first.body}\n#{@quotation.supplier.addresses.first.post_code}", 
        #at: [170,720], 
        #width: 200,
        align: :right 
  end
  
  def quote_number_and_date
      data = [["Ref.:","#{@quotation.code}","Date","#{@quotation.issue_date}"]]
      table(data) do
        cells.borders = []
        columns(2).align = :right
        columns(3).align = :right
        columns(0).width = 80
        columns(1).width = 300
        columns(2).width = 80
        columns(2).width = 80
      end
    end
    
    def quote_comment
      move_down 15
      text "#{@quotation.name}\n", style: :bold, size: 14
      move_down 6
      text "#{@quotation.description}", style: :italic
    end
     
    def quote_table
      move_down 15
      table quote_lines do
        row(0).font_style = :bold
        columns(2).align = :right
        columns(3).align = :right
        columns(4).align = :right
        self.header = true
        cells.borders = []
        row(0).borders = [:bottom]
        row(-1).borders = [:bottom]
        row(0).border_width = 0.5
        row(-1).border_width = 0.5
        columns(0).width = 80
        columns(1).width = 245
        columns(2).width = 55
        columns(3).width = 80
        columns(4).width = 80
      end
    end
    
    def quote_lines
      [["Item", "Specification", "Quantity", "Unit Price","Total"]] +
      @quotation.quotation_lines.map do |line|
        [line.name, line.description, line.quantity, price(line.unit_price), price(line.total)]
      end
    end
    
    def quote_total
      move_down 15
      data = [["","Total:", "#{price(@quotation.total)}"]]
      table(data) do
        cells.borders = []
        columns(1).align = :right
        columns(2).align = :right
        columns(0).width = 380
        columns(1).width = 80
        columns(2).width = 80
      end
    end
  
  #   def payment_details
  #     # move_down 20
  #     if cursor < 200 #cursor lower than 100
  #       start_new_page
  #     end
  #     #bounding_box([0,100], width: 350, height: 100) do
  #       text "Please make payment to:", size: 10
  #       table([
  #           ["compnay Ltd", ""],
  #           ["Lloyds TSB Plc", ""],
  #           ["Stratford upon Avon",""],
  #           ["Sort Code:","99-99-99"],
  #           ["Account No:","999999"],
  #           ["BIC:","LOYDGB21093"],
  #           ["IBAN:","GB20 LOYD 3098 2641 1140 60"]
  #           ]) do
  #         cells.borders = []
  #         # # columns(1).align = :right
  #         # # columns(2).align = :right
  #         cells.padding = [0,0,0,0]
  #         cells.size = 10
  #         columns(0).width = 100
  #         columns(1).width = 150
  #         columns(1).font_style = :bold
  #       end
  #     #end
  #   end
    
    def price(num)
      @view.number_to_currency(num)
    end
    
    def sales_quote_page_number
      string = "page <page> of <total>"
      options = {at: [bounds.right - 150,0],
                width: 150,
                align: :right,
                size: 8,
                start_count: 1
                }
      number_pages string, options
    end
end