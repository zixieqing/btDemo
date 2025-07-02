### CharacterController 使用
好的,我来举一个例子来说明 CharacterController 的使用。

假设我们有一个简单的第三人称角色游戏,玩家可以控制一个角色在场景中移动和跳跃。我们可以使用 CharacterController 组件来实现这个功能。

首先,我们需要在游戏对象上添加 CharacterController 组件:

1. 在 Unity 编辑器中,选择代表角色的游戏对象。
2. 在 Inspector 面板中,添加 CharacterController 组件。

接下来,我们可以编写一个脚本来控制角色的移动和跳跃:

```csharp
using UnityEngine;

public class CharacterMovement : MonoBehaviour
{
    public float moveSpeed = 5f;
    public float jumpForce = 10f;

    private CharacterController characterController;
    private float verticalVelocity = 0f;

    void Start()
    {
        characterController = GetComponent<CharacterController>();
    }

    void Update()
    {
        // 获取水平移动输入
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");

        // 计算移动向量
        Vector3 movement = new Vector3(horizontal, 0f, vertical);
        movement = transform.TransformDirection(movement);
        movement *= moveSpeed;

        // 处理跳跃
        if (characterController.isGrounded && Input.GetButtonDown("Jump"))
        {
            verticalVelocity = jumpForce;
        }

        // 应用重力
        verticalVelocity -= 9.81f * Time.deltaTime;

        // 使用 CharacterController 移动角色
        characterController.Move(movement * Time.deltaTime);
        characterController.Move(Vector3.up * verticalVelocity * Time.deltaTime);
    }
}
```

在这个例子中, 我们使用 `CharacterController.Move()` 方法来移动角色。 我们首先根据玩家的输入计算出一个移动向量,  然后将其传递给 `Move()` 方法。

对于跳跃, 我们检查角色是否在地面上, 如果玩家按下跳跃键,我们就给角色一个向上的初速度。同时,我们还应用重力,使角色下落。

通过使用 CharacterController 组件,我们可以轻松地实现角色的基本移动和跳跃功能,而不需要处理复杂的物理计算。这使得开发游戏角色控制变得更加简单和高效。

```
