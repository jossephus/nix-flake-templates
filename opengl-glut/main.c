#include <GL/glut.h>

// Function to initialize OpenGL
void init() {
    // Set clear color to black
    glClearColor(0.0, 0.0, 0.0, 1.0);
}

// Function to draw contents of the window
void display() {
    // Clear the color buffer
    glClear(GL_COLOR_BUFFER_BIT);

    // Draw a triangle
    glBegin(GL_TRIANGLES);
        glColor3f(1.0, 0.0, 0.0); // Red
        glVertex2f(0.0, 1.0);     // Top
        glColor3f(0.0, 1.0, 0.0); // Green
        glVertex2f(-1.0, -1.0);   // Bottom left
        glColor3f(0.0, 0.0, 1.0); // Blue
        glVertex2f(1.0, -1.0);    // Bottom right
    glEnd();

    // Flush OpenGL buffer to the window
    glFlush();
}

// Main function
int main(int argc, char** argv) {
    // Initialize GLUT
    glutInit(&argc, argv);

    // Set display mode: single buffer, RGB color, and depth buffer
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);

    // Set window size and position
    glutInitWindowSize(500, 500);
    glutInitWindowPosition(100, 100);

    // Create a window with given title
    glutCreateWindow("OpenGL - Simple Triangle");

    // Call initialization function
    init();

    // Register display function
    glutDisplayFunc(display);

    // Enter the event-processing loop
    glutMainLoop();

    return 0;
}

