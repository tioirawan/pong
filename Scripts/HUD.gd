extends CanvasLayer

func update_score(leftScore, rightScore):
	$LeftScoreLabel.text = str(leftScore)
	$RightScoreLabel.text = str(rightScore)
