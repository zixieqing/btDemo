// 三角形
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <iostream>
class Sanjiaoxing
{
private:
    const char* vertexShaderSource = "#version 330 core\n"
        "layout (location = 0) in vec3 aPos;\n"
        "void main()\n"
        "{\n"
        "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
        "}\0";


    const char* fragmentShaderSource = "#version 330 core\n"
        "out vec4 FragColor;\n"
        "uniform vec4 ourColor;\n"
        "void main()\n"
        "{\n"
        "   FragColor = ourColor;\n"
        "}\n\0";
    unsigned int vertexShader;
    unsigned int fragmentShader;
    unsigned int shaderProgram;
    unsigned int VBO;
    unsigned int VAO;
    int success;
    char infoLog[512];



public:
    Sanjiaoxing();
    ~Sanjiaoxing();

    void preloadVBO();
    void createVertexShader();
    void createFragmentShader();
    void linkToProgram();
    void linkVertexData();

    void checkIsSuccess(unsigned int obj);

    void SanjiaoxingCreate();

    void run();
    void terminal();
};
