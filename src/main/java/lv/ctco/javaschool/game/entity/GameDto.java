package lv.ctco.javaschool.game.entity;

import lombok.Data;

/**
 * Created by kristaps.lipsha01 on 8/15/2018.
 */
@Data
public class GameDto {
    private GameStatus status;
    private boolean playerActive;
}
