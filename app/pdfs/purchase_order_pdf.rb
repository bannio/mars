class PurchaseOrderPdf < Prawn::Document
	def initialize(purchase_order)
    super(bottom_margin: 50)
    @purchase_order = purchase_order
    
    define_grid(columns: 3, rows: 6, gutter: 0)
    #grid.show_all
    font_size 10
    
    grid([0,1],[0,2]).bounding_box do
      logo
    end
    
    grid([0,0],[0,1]).bounding_box do
      purchase_order_heading
    end

    grid([1,0],[1,1]).bounding_box do
      address_box
    end

    grid([1,1],[1,1]).bounding_box do
      text "Deliver to:  ", align: :center,
                            style: :bold,
                            size:  12
    end

    grid([1,2],[1,2]).bounding_box do
      delivery_address
    end

    order_number_and_dates
    order_comment
    order_table
    order_total
    poterms
    fold_mark
    our_address
    purchase_order_number
    purchase_order_page_number
    
    
  end
  
  def fold_mark
    repeat([1]) do         # only on first page
      transparent(0.5){stroke_horizontal_line -20, -10, at: 464 }
    end
  end
  
  def address_box
    if @purchase_order.address
    text_box "#{@purchase_order.supplier.name}
              #{@purchase_order.address.body}
              #{@purchase_order.address.post_code}",
              size: 10 
    else
      text_box "MISSING AN ADDRESS!"
    end
  end
  
  def delivery_address
    if @purchase_order.delivery_address
      move_down 6
      text_box "#{@purchase_order.delivery_name}
                #{@purchase_order.delivery_address.body}
                #{@purchase_order.delivery_address.post_code}",
                size: 10 
    else
      text_box "MISSING AN ADDRESS!"
    end
  end

  def purchase_order_heading
    move_down 50
    text "Purchase Order", 
          size: 20, 
          style: :bold
  end
  
  def logo
    if @purchase_order.customer.name.include? "Roger"
      image "#{Rails.root}/app/assets/images/RBDC_logo.png",
      postion: :right,
      fit: [350,50]
    else
      image "#{Rails.root}/app/assets/images/blue_square_logo.png",
      position: :right,
      vposition: :center,
      fit: [70,70]
    end
  end
  
  def order_number_and_dates
    date = @purchase_order.issue_date ? @purchase_order.issue_date.strftime("%d %B %Y") : "NOT ISSUED"
    due_date = @purchase_order.due_date ? @purchase_order.due_date.strftime("%d %B %Y") : "NOT SET"
    data = [["Order No.:","#{@purchase_order.code}","Date", date],["Delivery Date:", due_date,"",""]]
    table(data) do
      cells.borders = []
      columns(2).align = :right
      columns(1).font_style = :bold
      columns(3).align = :right
      columns(0).width = 80
      columns(1).width = 250
      columns(2).width = 110
      columns(3).width = 100
    end
  end
    
    def order_comment
      move_down 15
      text "#{@purchase_order.name}\n", style: :bold, size: 12
      move_down 6
      text "#{@purchase_order.description}", style: :italic
    end
     
    def order_table
      move_down 15
      table order_lines do
        row(0).font_style = :bold
        columns(0).align = :right
        columns(3).align = :right
        columns(4).align = :right
        columns(5).align = :right
        self.header = true
        cells.borders = []
        row(0).borders = [:bottom]
        row(-1).borders = [:bottom]
        row(0).border_width = 0.5
        row(-1).border_width = 0.5
        columns(0).width = 20       # row number
        columns(0).size = 9
        columns(1).width = 75       # item (name)
        columns(1).size = 9
        row(0).size = 10
        columns(2).width = 240      # specification (description)
        columns(3).width = 55       # quantity
        columns(4).width = 75       # unit_price
        columns(5).width = 75       # total
      end
    end
    
    def order_lines
      rowno = 0
      [["","Item", "Specification", "Quantity", "Unit Price","Total"]] +
      @purchase_order.purchase_order_lines.map do |line|
        [rowno += 1, line.name, line.description, line.quantity, price(line.unit_price), price(line.total)]
      end
    end
    
    def order_total
      move_down 15
      data = [["","Total (excluding VAT):", "#{price(@purchase_order.total)}"]]
      table(data) do
        cells.borders = []
        columns(1).align = :right
        columns(2).align = :right
        columns(0).width = 340
        columns(1).width = 120
        columns(2).width = 80
      end
    end
    
    def price(num)
      helpers.number_to_currency(num)
    end

    def poterms
      move_down 20
      content = "The Supplier shall ensure that all Products despatched from their premises "\
                "are properly packed and secured in such manner as to enable them to "\
                "reach their destination in good condition. In cases where the Products "\
                "are not despatched from the Supplier's premises, the Supplier shall notify "\
                "the party who despatches the Products to do so in a manner that ensures "\
                "that the Products are properly packed and secured in such manner as to " \
                "enable them to reach their destination in good condition"
      text content, style: :italic, size: 8
    end
    
    def our_address
      if @purchase_order.customer.addresses.first
        addr = "#{@purchase_order.customer.addresses.first.body.gsub(/\n/,', ')}, #{@purchase_order.customer.addresses.first.post_code}"
        if @purchase_order.customer.name.include? "Elderberry"
          addr = addr + "\nRegistered No. 2993752 VAT Reg No. 619 9162 14"
        end
      else
        addr = "address missing"
      end

      repeat(:all) do
        canvas do
          move_cursor_to 30
          line_width 0.1
          transparent(0.5){
          stroke_horizontal_rule}
          text_box addr, at: [30,20], align: :center, size: 8
        end
      end
    end
    
    def purchase_order_page_number
      string = "page <page> of <total>"
      options = { at: [500, 20],
                width: 70,
                align: :right,
                size: 8,
                start_count: 1
                }
      canvas do
        number_pages string, options
      end
    end

    def purchase_order_number
      string = @purchase_order.code
      options = { at: [30, 20],
                width: 30,
                align: :left,
                size: 8
                }
      repeat(:all) do
        canvas do
          text_box string, options
        end
      end
    end
    
    def helpers
      ActionController::Base.helpers
    end
end