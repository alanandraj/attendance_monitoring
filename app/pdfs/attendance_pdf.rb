class AttendancePdf < Prawn::Document
  def initialize(at)
    super(top_margin: 70)
    @at = at
    @at.each do |rec|
      text "#{rec.date}"
    end
  end
end