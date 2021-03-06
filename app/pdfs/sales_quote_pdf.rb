class SalesQuotePdf < Prawn::Document
  def initialize(quotation)
    super(bottom_margin: 72)
    @quotation = quotation

    define_grid(columns: 3, rows: 6, gutter: 0)
    # grid.show_all
    # stroke_axis

    font_setup
    font_size 10

    grid([0,0],[0,1]).bounding_box do
      logo
    end

    grid([0,0],[0,1]).bounding_box do
      sales_quote_heading
    end

    grid([1,0],[1,1]).bounding_box do
      address_box
    end

    quote_number_and_date
    quote_comment
    quote_table
    quote_total
    fold_mark
    footer

  end

  def font_setup
    font_families.update("GillSansLight" => {
      :normal => "#{Rails.root}/app/assets/fonts/GillSans-Light-08.ttf",
      :italic => "#{Rails.root}/app/assets/fonts/GillSans-LightItalic-09.ttf",
      :bold => "#{Rails.root}/app/assets/fonts/GillSans-SemiBold-05.ttf",
    })
    font "GillSansLight"
  end

  def fold_mark
    repeat([1]) do         # only on first page
      transparent(0.5){stroke_horizontal_line -20, -10, at: 464 }
    end
  end

  def address_box
    if @quotation.address
    text_box "#{@quotation.customer.name}
              #{@quotation.address.body}
              #{@quotation.address.post_code}",
              size: 10
    else
      text_box "MISSING AN ADDRESS!"
    end
  end

  def sales_quote_heading
    move_down 40
    text "Sales Quotation",
          size: 20,
          style: :bold
  end

  def logo
    if @quotation.supplier.name.include? "Roger"
      image "#{Rails.root}/app/assets/images/RBDC_logo.png",
      at: [-10,cursor]
    else
      image "#{Rails.root}/app/assets/images/ElderberryLogo.png",
      at: [-2,cursor],
      fit: [375,75]
    end
  end

  def quote_number_and_date
    date = @quotation.issue_date ? @quotation.issue_date.strftime("%d %B %Y") : "NOT ISSUED"
    data = [["Ref.:","#{@quotation.code}","Date", date]]
    table(data) do
      cells.borders = []
      columns(2).align = :right
      columns(3).align = :right
      columns(1).font_style = :bold
      columns(3).font_style = :bold
      columns(0).width = 80
      columns(1).width = 250
      columns(2).width = 110
      columns(3).width = 100
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
        # self.width = 540
        row(0).font_style = :bold
        # columns(0).align = :right
        columns(3).align = :right
        columns(4).align = :right
        columns(5).align = :right
        self.header = true
        cells.borders = []
        row(0).borders = [:bottom]
        row(-1).borders = [:bottom]
        row(0).border_width = 0.5
        row(-1).border_width = 0.5
        row(0).size = 10
        columns(0).width = 20       # row number
        columns(0).size = 9
        columns(1).width = 75       # item (name)
        columns(1).size = 9
        columns(2).width = 235      # specification (description)
        columns(3).width = 55       # quantity
        columns(4).width = 75       # unit_price
        columns(5).width = 75       # total
      end
    end

    def quote_lines
      output = []
      rowno = 0
      cat = ""
      output << ["","Item", "Specification", "Quantity", "Unit Price","Total"]
      @quotation.quotation_lines.each do |line|
        if cat == line.category
          output << ["#{'%02i' % rowno += 1}", line.name, line.description, line.quantity, price(line.unit_price), price(line.total)]
        else
          cat = line.category
          output << [{content: line.category, colspan: 3, font_style: :bold},"","",""]
          output << ["#{'%02i' % rowno += 1}", line.name, line.description, line.quantity, price(line.unit_price), price(line.total)]
        end
      end
      output
    end

    def quote_total
      move_down 15
      data = [["","Total (excluding VAT):", "#{price(@quotation.total)}"]]
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

    def footer

      # Table with three columns but not able to make 'number_pages' work in
      # cells so only two column's used

      data = [[quotation_number, our_address, ""]]

      repeat(:all) do
        move_cursor_to -25
        transparent(0.5){stroke_horizontal_rule}
        canvas do       # overrules margin bounding box to work outside margins
          font_size 8
          bounding_box [bounds.left + 30, bounds.bottom + 40], width: 540 do

            table(data) do
              cells.borders = []
              columns(0).align = :left
              columns(1).align = :center
              columns(2).align = :right
              columns(0).width = 100
              columns(1).width = 340
              columns(2).width = 100
            end
          end
        end
      end
      sales_quote_page_number

    end

    def our_address
      if @quotation.supplier.addresses.first
        addr = "#{@quotation.supplier.addresses.first.body.gsub(/\n/,', ')}, #{@quotation.supplier.addresses.first.post_code}"
        if @quotation.supplier.name.include? "Elderberry"
          addr = addr + "\nRegistered No. 2993752 VAT Reg No. 619 9162 14"
        end
      else
        addr = "address missing"
      end
    end

    def sales_quote_page_number
      string = "page <page> of <total>"

      options = {
                at: [450, -40],
                width: 90,
                align: :right,
                size: 8,
                start_count: 1
                }

      repeat(:all, dynamic: true) do
        number_pages string, options
      end
    end

    def quotation_number
      @quotation.code
    end

    def helpers
      ActionController::Base.helpers
    end
end
