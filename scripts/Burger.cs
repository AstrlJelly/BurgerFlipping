using Godot;
using System;

namespace BurgerFlipping;

public partial class Burger : Node
{
	// [Export] public float TransitionSpeed;
	[Export] private Sprite2D sprite;
	[Export] private float cookTime = 5;
	private Vector2 cookedPercentages = new(0, 0);

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		sprite.Material = (Material)sprite.Material.Duplicate();
		sprite.Material.Set("cookedPercentages", new Vector2());
		GD.Print(cookTime);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		cookedPercentages.Y += (float)(delta / cookTime);
		GD.Print("cookedPercentages : " + (Vector2)sprite.Material.Get("cookedPercentages"));
		sprite.Material.Set("cookedPercentages", cookedPercentages);
	}
}
