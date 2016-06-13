require 'opengl'
require 'glu'
require 'glut'
require 'mathn'

include Gl
include Glu
include Glut

window = nil

def init_gl_window width = 640, height = 480
    #Background color to black
    glClearColor 0.0, 0.0, 0.0, 0
    #Enables clearing of depth buffer
    glClearDepth 1.0
    #Set type of depth test
    glDepthFunc GL_LEQUAL
    #Enable depth testing
    glEnable GL_DEPTH_TEST
    #Enable smooth color shading
    glShadeModel GL_SMOOTH

    glMatrixMode GL_PROJECTION
    glLoadIdentity
    #Calculate aspect ratio of the window
    gluPerspective 45.0, width / height, 0.1, 100.0

    glMatrixMode GL_MODELVIEW

    draw_gl_scene
end

#reshape = Proc.new do |width, height|
def reshape width, height
    height = 1 if height == 0

    #Reset current viewpoint and perspective transformation
    glViewport 0, 0, wigth, height

    glMatrixMode GL_PROJECTION
    glLoadIdentity

    gluPerspective 45.0, width / height, 0.1, 100.0
end

def drawline x1, y1, x2, y2
    glBegin GL_LINES do
        glVertex3f x1, y1, 0.0
	glVertex3f x2, y2, 0.0
    end
end

def movex x
    glTranslatef x, 0.0, 0.0
end


def drawWord word, spacing
    word.each_char do |c|
        drawLetter c
	movex spacing
    end
end

def drawLetter letter
    letters = {"k"=> [[0.0, -1.0, 0.0, 1.0], [0.0, 0.0, 1.0, 1.0], [0.0, 0.0, 1.0, -1.0]], "e"=> [[0.0, -1.0, 0.0, 1.0], [0.0, 1.0, 0.75, 1.0], [0.0, 0.0, 0.5, 0.0], [0.0, -1.0, 0.75, -1.0]],
    "v"=> [[0.0, 1.0, 0.5, -1.0], [0.5, -1.0, 1.0, 1.0]], "i"=> [[0.5, 1.0, 0.5, -1.0], [0.0, 1.0, 1.0, 1.0], [0.0, -1.0, 1.0, -1.0]], "n"=> [[0.0, -1.0, 0.0, 1.0], [0.0, 1.0, 1.0, -1.0], [1.0, -1.0, 1.0, 1.0]]}
    on = letters[letter]
    on.each do |coords|
        drawline coords[0], coords[1], coords[2], coords[3]
    end
end

#draw_gl_scene = Proc.new do
def draw_gl_scene
    #Clear the screen and depth buffer
    glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT

    #Reset the view
    glMatrixMode = GL_MODELVIEW
    glLoadIdentity
    
    #Move left 3 units and into the screen 10.0 units
    glTranslatef -3, 0.0, -10.0

    #Draw a triangle
    #glBegin GL_POLYGON do
    #    glVertex3f 0.0, 1.0, 0.0
    #    glVertex3f 1.0, -1.0, 0.0
    #    glVertex3f -1.0, -1.0, 0.0
    #end
    
    #Move right 3 units
    #glTranslatef 3.0, 0.0, 0.0

    #Draw a rectangle
    #glBegin GL_QUADS do
    #    glVertex3f -1.0,  1.0, 0.0
    #    glVertex3f  1.0,  1.0, 0.0
    #    glVertex3f  1.0, -1.0, 0.0
    #    glVertex3f -1.0, -1.0, 0.0
    #end
    #Move up 1 unit
    
    drawWord "kevin", 1.5

    #glTranslatef 0.0, 1.0, 0.0
    #drawLetter "k"
    #movex 1.5
    #drawLetter "e"
    #movex 1.5
    #drawLetter "v"
    #movex 1.5
    #drawLetter "i"
    #movex 1.5
    #drawLetter "n"
    #Swap buffers for display
    glutSwapBuffers
end

#The idle function to handle
def idle
    glutPostRedisplay
end

#Keyboard handler to exit when ESC is typed
keyboard = lambda do |key, x, y|
    case key
    when ?\e
        glutDestroyWindow window
	exit(0)
    end
    glutPostRedisplay
end

#Initialize our GLUT code
glutInit
#Setup a double buffer, RGBA color, alpha components and depth buffer
glutInitDisplayMode GLUT_RGB | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH
glutInitWindowSize 640, 480
glutInitWindowPosition 0, 0
window = glutCreateWindow "Does this work?"
glutIdleFunc :idle
glutDisplayFunc :draw_gl_scene
glutKeyboardFunc keyboard
init_gl_window 640, 480
glutMainLoop






















