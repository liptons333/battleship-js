package lv.ctco.javaschool.game.control;

import lv.ctco.javaschool.auth.entity.domain.User;
import lv.ctco.javaschool.game.entity.Cell;
import lv.ctco.javaschool.game.entity.CellState;
import lv.ctco.javaschool.game.entity.Game;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class HighScoreStore {
    @PersistenceContext
    private EntityManager em;

    public int countWinMoves(Game game, User player) {
        return em.createQuery("Select c from Cell c " +
                "where c.game=:game and c.user=:user and c.targetArea=true and (c.state=:hit or c.state=:miss)", Cell.class)
                .setParameter("game",game)
                .setParameter("user", player)
                .setParameter("hit", CellState.HIT)
                .setParameter("miss", CellState.MISS)
                .getResultList()
                .size();
    }

    //TODO: Check if new high score is better than old one
    public void checkNewScore() {

    }
}
