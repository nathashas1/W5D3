require 'rack'

class ControllerBase 
  
  def initialize(req,res)
    @req = req
    @res = res
    @alreadybuiltresponse = false
  end

  attr_accessor :alreadybuiltresponse
  
  def render_content(content, content_type)
    @res.write(content) 
    @res.status = 200 
    # @res.write the default is 200
    @res['content_type']= content_type
    nil 
  end
  
  def redirect_to(url)
    @res.status = 300
    @res['location'] = url
  end

end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  controller = ControllerBase.new(req, res)
  controller.render_content('Hello Natasha!', 'text/html')
  controller.alreadybuiltresponse = true
  # res['Content-Type'] = 'text/html'
  # res.write("Hello Natasha!")
  res.finish
  # [HTML CODE = 200, {HEAD_HASH}, ['TEXT']]
end 

Rack::Server.start({
  app: app,
  port: 3000
})
