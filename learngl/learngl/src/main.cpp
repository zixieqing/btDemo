#include <iostream>
#include "test/test.h"

#include "test/FirstGLWin.h"
#include "test/Sanjiaoxing.h"
int main()
{
    test* testobj = new (std::nothrow) test();
    testobj->testPrint();


    ////window
    FirstGLWin* glWin = new FirstGLWin();
    glWin->FirstGLWinCreate();
    GLFWwindow* window = glWin->window;

    ////sanjiaoxing
    Sanjiaoxing* sjx = new Sanjiaoxing();
    sjx->SanjiaoxingCreate();


    //////·ÀÖ¹¹Ø±Õ
    while (!glfwWindowShouldClose(window))
    {
        glWin->run();
        sjx->run();
    }

    glWin->terminal();
    sjx->terminal();
}





