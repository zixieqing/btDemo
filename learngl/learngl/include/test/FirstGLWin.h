// GL 创建一个窗口
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <iostream>
class FirstGLWin
{
private:

public:
    FirstGLWin();
    ~FirstGLWin();
    GLFWwindow* window;
    void framebuffer_size_callback(GLFWwindow* window, int width, int height);
    void processInput(GLFWwindow* window);
    void FirstGLWinCreate();
    void run();
    void terminal();
 
};
