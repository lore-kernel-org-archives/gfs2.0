Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917403AB476
	for <gfs2@lists.linux.dev>; Sun, 23 Aug 2026 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511756; cv=none; b=WsROqU5gPDwB11zNMJezGQnaCzF0T2eq6hSsMVYnQszBXHGaTGYT4Ltxer3l0Dz8SMmv9ALIxHVkb0XiS6KeUccv9wyccgCheWR55p2sujBuotevMpGN5AK+q4sDhJwYk4mKgvvcpQPCRaXlA+PM2jSHPtjbQCYsSi0EZ1qy6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511756; c=relaxed/simple;
	bh=2xZFs4YyAVM1Oysqs8KygXp7OjjhPeA088J7PjqZTEI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y9DyJakNjmwMv3K0pOBNhLIQWaLyRGUpc1aFQtEDMyHRjbfpPGjGg/uulBkCASWNvMLKuOx4BYxtbdxC8iiqRCnkmzdqNdUQeIxhoVyXaRP88XVP2wF+Gy/5vioT/Hgh2r48eGiM2BjDSYWaEj3llo3NHgsRA2RTnwrbusoeGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiQlv/lb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiQlv/lb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1172816f8f.1
        for <gfs2@lists.linux.dev>; Sun, 23 Aug 2026 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787511753; x=1788116553; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QfJVzCuLHpC3ZJt+FFsZ8Wq8eOQLemGNZcwnQPoiors=;
        b=qiQlv/lb0Q/K5dSdz11o1BgXYQuuwz24NI+D/Ea+DWTfvOF9hHZfkZJyxrMC7ja4sG
         6dqsw0vVzM4E743LkrYoNumsPVgjNJ1bBs03N0Vq4Xo6dGt/a1gy3JxT0mS1YUOd8d8X
         aZY3vx/9ILnbo7pth6e38o2t/gLYyWUdLWekbRz5WGQoJ31TjQk3QCOYWeCV9iGYgQZ4
         nGjGqTaVI4+0GI7XP9CC77mIKw6sRQ9ngpKstFHfTW2OG/LouhpoXTEhfDll+w6AU2S6
         LS8924kRjkeF+16TgKsX/gCHaDC84Vhv/fsgVDok6sl5ih6VbG9VI8UwQTmsUUp/Vjao
         t+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511753; x=1788116553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QfJVzCuLHpC3ZJt+FFsZ8Wq8eOQLemGNZcwnQPoiors=;
        b=GoYEI3ZZKQq97Ke0B/PP34RO46Y5lucEDUgguxNHzgTA8ix5ur4exa5pKSb8ghmtlz
         W5J7dPLDSaYNdg/MYXf/UfTC3z0774iVD8hvkBMsUzDUzvEeEhSmSY6XycUce8YNvp2Z
         hKiT1hY/sdrETqUG/FA4ayy8s8LNYfqNGmPq3aYsbqS3Mk2dOLfpVnCwJBgkng4z/pxQ
         eMnFKHm1yZvY8m2lXf8dCVMRfkoW0AcYrkQj43mExtdF3K/pcbaXE7DMO1SIVwI2r9V9
         ko4uTOf0ebR04MOzmWU7Sazr04fRG3kPg9ocfmpryTwFHuqXTBFaZFqZxIG93MVnZuNO
         tyvw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2YNux3yZAUwdL8V0QXxULmXSLSUG0PFN5MxnPbNypDCb5VfxCwyijUcuuQ91hEIFuJUk8@lists.linux.dev
X-Gm-Message-State: AFuF++nZczIHz/I7nVqBYNNGq2Xg0sX42zfdMPSgHuBHlgefvo8JpT2K
	sDJ+2uu5SqQRc6MPf9QVvx/8KyamvNPZG1udZXE4p6iS/CWuwnvSCRto
X-Gm-Gg: AR+sD12zAlEEJZntZy9OdOEG8wR1ZEuK3VeA4bMyik9d10z9MpPcGuMBRAHtb77g4N+
	kTaJfi9FO+Iots1MT/APJfn+yAVEr6f7ZPD4YrC4/A9XOSu9m4UsFy+l0g9Nz4v5AM4fPaia7K0
	8jJSFbh9gNI7x24yHGKxa9/7LXxa2jECnz765cg1/5vcNMwinrb7iaz1BgD3mClfoTMfUNprYON
	h5Q47VIY3VWwFvLPENUKelMG3iF/AVYkt4GLM5gH96REyT0nCi0sYP20WL7B5V8PM//L1XrU+VE
	KRJwOsjiVQZ7L480NYJpu2NDIgGayeY3WUo2uKOfBACLA5xnZSa9Y2d8At9ra0PyQZqLaIUDTxv
	iXAocWpE6ZeT/chhkTqAjWsQWKmjLKDi6aWTLsV5CDEECEdBiJBgxUtavp66y2V94346CKvpgaO
	AWubVegQf4WIui51V2h4parGYxhjK/v2NrKGQ6ZWfJuQ6Kv79sqdU9bdKn
X-Received: by 2002:a05:6000:2f87:b0:47f:fe45:e597 with SMTP id ffacd0b85a97d-482c0b4a3edmr24131549f8f.3.1787511752571;
        Sun, 23 Aug 2026 12:02:32 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b69b7fsm5860050f8f.2.2026.08.23.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:02:31 -0700 (PDT)
Date: Sun, 23 Aug 2026 22:02:28 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev,
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gfs2: annotate i_gl with __rcu and convert to
 accessor helpers
Message-ID: <202608240109.e8n1gQMm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a74d41a.f3f7def5.e164f.560e@mx.google.com>

Hi Adrian,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Garcia-Casado/gfs2-annotate-i_gl-with-__rcu-and-convert-to-accessor-helpers/20260806-113610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
patch link:    https://lore.kernel.org/r/6a74d41a.f3f7def5.e164f.560e%40mx.google.com
patch subject: [PATCH v2] gfs2: annotate i_gl with __rcu and convert to accessor helpers
config: x86_64-randconfig-161 (https://download.01.org/0day-ci/archive/20260824/202608240109.e8n1gQMm-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202608240109.e8n1gQMm-lkp@intel.com/

New smatch warnings:
fs/gfs2/inode.c:150 gfs2_inode_lookup() warn: inconsistent indenting

vim +150 fs/gfs2/inode.c

194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  127  struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
3ce37b2cb49176 fs/gfs2/inode.c     Andreas Gruenbacher  2016-06-14  128  				u64 no_addr, u64 no_formal_ino,
3ce37b2cb49176 fs/gfs2/inode.c     Andreas Gruenbacher  2016-06-14  129  				unsigned int blktype)
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  130  {
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  131  	struct inode *inode;
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  132  	struct gfs2_inode *ip;
3ce37b2cb49176 fs/gfs2/inode.c     Andreas Gruenbacher  2016-06-14  133  	struct gfs2_holder i_gh;
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  134  	int error;
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  135  
6df9f9a253c7dc fs/gfs2/inode.c     Andreas Gruenbacher  2016-06-17  136  	gfs2_holder_mark_uninitialized(&i_gh);
5f6e13baebf31d fs/gfs2/inode.c     Andreas Gruenbacher  2021-11-29  137  	inode = iget5_locked(sb, no_addr, iget_test, iget_set, &no_addr);
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  138  	if (!inode)
ac3beb6a5de048 fs/gfs2/inode.c     Steven Whitehouse    2014-01-16  139  		return ERR_PTR(-ENOMEM);
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  140  
e97321fa095f1e fs/gfs2/inode.c     Bob Peterson         2016-04-12  141  	ip = GFS2_I(inode);
e97321fa095f1e fs/gfs2/inode.c     Bob Peterson         2016-04-12  142  
40a4c512ad2564 fs/gfs2/inode.c     Mateusz Guzik        2025-10-09  143  	if (inode_state_read_once(inode) & I_NEW) {
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  144  		struct gfs2_sbd *sdp = GFS2_SB(inode);
5f6e13baebf31d fs/gfs2/inode.c     Andreas Gruenbacher  2021-11-29  145  		struct gfs2_glock *io_gl;
c412a97cf6c525 fs/gfs2/inode.c     Bob Peterson         2022-08-22  146  		int extra_flags = 0;
194c011fc4650d fs/gfs2/ops_inode.c Steven Whitehouse    2011-05-09  147  
2c5f4a53476e3c fs/gfs2/inode.c     Andreas Gruenbacher  2025-11-13  148  		gfs2_setup_inode(inode);
f7e98cd66761db fs/gfs2/inode.c     Adrian Garcia Casado 2026-08-06  149  		{ struct gfs2_glock *gl;
f7e98cd66761db fs/gfs2/inode.c     Adrian Garcia Casado 2026-08-06 @150  		error = gfs2_glock_get(sdp, no_addr, &gfs2_inode_glops, CREATE, &gl);
f7e98cd66761db fs/gfs2/inode.c     Adrian Garcia Casado 2026-08-06  151  		if (!error)
f7e98cd66761db fs/gfs2/inode.c     Adrian Garcia Casado 2026-08-06  152  			rcu_assign_pointer(ip->i_gl, gl); }

What's going with the indenting?  This looks like debug code
accidentlly escaped?

29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  153  		if (unlikely(error))
29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  154  			goto fail;
29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  155  
29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  156  		error = gfs2_glock_get(sdp, no_addr, &gfs2_iopen_glops, CREATE,
29464ee36bcaae fs/gfs2/inode.c     Andreas Gruenbacher  2022-01-24  157  				       &io_gl);

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

