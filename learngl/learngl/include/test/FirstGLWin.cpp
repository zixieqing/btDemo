#include "FirstGLWin.h"
FirstGLWin::FirstGLWin(){

}
void FirstGLWin::FirstGLWinCreate(){
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);//�汾����Ϊ3.3
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE); //����ģʽ(Core-profile)
    //glfwglWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE); //MacOS ϵͳ

    //�������ڶ���
    window = glfwCreateWindow(800, 600, "LearnOpenGL", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
   
    }
    glfwMakeContextCurrent(window);

    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
    }
    glViewport(0, 0, 800, 600);

    //glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

}


void FirstGLWin::processInput(GLFWwindow* window)
{
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
}


void FirstGLWin::framebuffer_size_callback(GLFWwindow* window, int width, int height)
{

    glViewport(0, 0, width, height);
}

void FirstGLWin::run() {
    glfwSwapBuffers(window);
    glfwPollEvents();
    glClearColor(0.2f, 0.6f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    processInput(window);
}

void FirstGLWin::terminal() {
    glfwTerminate();

}