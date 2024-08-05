#include <iostream>
#include "test/test.h"

#include "test/FirstGLWin.h"
#include "test/Sanjiaoxing.h"
#include "test/Shader.h"
int main()
{
    test* testobj = new (std::nothrow) test();
    testobj->testPrint();


    //01window
    FirstGLWin* glWin = new FirstGLWin();
    glWin->FirstGLWinCreate();
    GLFWwindow* window = glWin->window;

    //02sanjiaoxing
   /* Sanjiaoxing* sjx = new Sanjiaoxing();
    sjx->SanjiaoxingCreate()*/;

    //03shader
    Shader sjxShader("sanjiaoxing.vs", "sanjiaoxing.fs"); 
    std::string shaderName = "sanjiaoxing";
    unsigned int VAO = sjxShader.customInputAndParse(shaderName);



    //·ÀÖ¹¹Ø±Õ
    while (!glfwWindowShouldClose(window))
    {
        glWin->run();
        //sjx->run();
        sjxShader.run(sjxShader, VAO);
    }

    glWin->terminal();
    //sjx->terminal();
    return 0;
}





