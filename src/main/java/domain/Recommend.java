package domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Recommend {
	private String title;
	private String description;
	private int priority;
}
