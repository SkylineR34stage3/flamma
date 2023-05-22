class PostDownloadService
  def self.assemble_pdf(post)
    Prawn::Document.new do
      font_families.update(
        "Roboto" => {
          normal: Rails.root.join("app", "assets", "fonts", "Roboto-Regular.ttf"),
          medium: Rails.root.join("app", "assets", "fonts", "Roboto-Medium.ttf"),
          bold: Rails.root.join("app", "assets", "fonts", "Roboto-Bold.ttf")
        }
      )
      font "Roboto", size: 14

      bounding_box([0, cursor], width: 540, height: 600) do
        image Rails.root.join("app", "assets", "images", "bob.png"), fit: [200, 200], position: :left
        move_down 20
        text post.title, size: 20, style: :bold
        move_down 5
        text post.subtitle, size: 16, style: :medium
        move_down 8
        text post.bich_text
        text "by: " + User.find(post.user_id).name
      end
    end
  end

end