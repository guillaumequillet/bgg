require 'gosu'
require 'opengl'
require 'glu'

OpenGL.load_lib
GLU.load_lib

include OpenGL, GLU

require_relative './window.rb'
require_relative './vector.rb'
require_relative './aabb.rb'
require_relative './texture.rb'
require_relative './tiled.rb'
require_relative './camera_3d.rb'
