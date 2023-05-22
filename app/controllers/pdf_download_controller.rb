require 'prawn'

class PdfDownloadController < ApplicationController
  def export_pdf
    post = Post.find(params[:id])

    pdf = PostDownloadService.assemble_pdf(post)

    send_data(pdf.render, filename: 'post.pdf', type: 'application/pdf')
  end
end