package com.lol.dao;

import java.util.List;

import com.lol.bean.Champ;
import com.lol.bean.Champlst;

public interface Iloldao {

	Champlst getChampInfo(int champ_code);

	Champlst getChampnameinfo(String champname);

	Champlst getChampionnameinfo(String championname);

	List<Champlst> getChampionlist();

	List<Champlst> getChampionTierlist();

	List<Champ> getChampLst();


}
