package com.khomsi.grid.main.game.mapper;

import com.khomsi.grid.main.game.model.dto.MainGameModel;
import com.khomsi.grid.main.game.model.entity.Game;

public interface GameMapper {
    MainGameModel toMainGames(Game game);
}