package com.moiza.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moiza.entity.Authorities;
import com.moiza.entity.MgroupEntity;
import com.moiza.entity.PostEntity;
import com.moiza.entity.UserEntity;
import com.moiza.entity.UsergroupEntity;
import com.moiza.dao.MoizaDao;

@Service
public class MoizaServiceImpl implements MoizaService {

	@Autowired
	private MoizaDao moizaDao;

	@Override
	@Transactional
	public int UseridChangeUserindex(String userId) {
		return moizaDao.UseridChangeUserindex(userId);
	}

	@Override
	@Transactional
	public List<MgroupEntity> getSubscribedMgroup(int userIndex) {
		return moizaDao.getSubscribedMgroup(userIndex);
	}

	@Override
	@Transactional
	public void saveUser(UserEntity user) {
		moizaDao.saveUser(user);

	}

	@Override
	@Transactional
	public List<MgroupEntity> getConnectedGroupInfo(int groupIndex) {
		return moizaDao.getConnectedGroupInfo(groupIndex);
	}

	@Override
	@Transactional
	public List<PostEntity> getConnectedGroupPosts(int groupIndex) {
		return moizaDao.getConnectedGroupPosts(groupIndex);
	}

	@Override
	@Transactional
	public List<UsergroupEntity> getUserGroup(int userIndex, int mgroupIndex) {
		return moizaDao.getUserGroup(userIndex, mgroupIndex);
	}

	@Override
	@Transactional
	public void saveWrittenPost(PostEntity bowOfPost) {
		moizaDao.saveWrittenPost(bowOfPost);
	}

	@Override
	@Transactional
	public int findMgroupIndexBase(int getUsergroup_index) {
		return moizaDao.findMgroupIndexBase(getUsergroup_index);

	}

	@Override
	@Transactional
	public void saveUser1(UserEntity user) {
		moizaDao.saveUser1(user);

	}

	@Override
	@Transactional
	public void saveAuthority(Authorities authorities) {
		moizaDao.saveAuthority(authorities);

	}

	@Override
	@Transactional
	public void saveGroup(MgroupEntity mgroup) {
		moizaDao.saveGroup(mgroup);
	}

	@Override
	@Transactional
	public void makeTheLeader(UsergroupEntity usergroupEntity) {
		moizaDao.makeTheLeader(usergroupEntity);
		
	}

}
