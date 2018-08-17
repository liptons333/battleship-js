package lv.ctco.javaschool.game.entity;

import lombok.Data;
import lv.ctco.javaschool.auth.entity.domain.User;

@Data
public class HihgScoreDto {
    private User user;
    private int moves;
}
