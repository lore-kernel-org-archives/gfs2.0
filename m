Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C918A;
	Mon, 30 Oct 2023 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8pzeTus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698624774; x=1730160774;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5scbjYtPQiTBL1UjLla0DuWP1ShKUcIByrXU/hBPx1w=;
  b=N8pzeTusS9e2cGQUEMFeU2aInO3OZN4nQEZnSUUN32PlZk446S1q0zcr
   ucd1Xs8fnFIYgmHeFqSHPIimiRWBms+EgKVC0o9MrD2hBjG2hX22rOLql
   AY3oMvSvt7xFhcdbX69+ZfmKVIMxvpdzV/+EbPKUxFiBV1aYfYMXf0rBY
   yiWPtFl3IYaWfy32zSXU+MrKEnxErinRuER0RhI+5BbTDFzdOMmRBBM7Z
   QtrFlgg5zrLlgMtVcovLwfK2r+xuN+L7ejpgJvnKSWpxWWNZfwiXFiHDc
   HZUhlrIy5NkOXDeU2wWpX56r2SNwEoAHpxrBrblX2MOXXpStvMsBo42dX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="378363929"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="378363929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 17:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="850756701"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="850756701"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Oct 2023 17:12:52 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qxFth-000Cv3-38;
	Mon, 30 Oct 2023 00:12:49 +0000
Date: Mon, 30 Oct 2023 08:12:40 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:alloc 52/70] fs/gfs2/bmap.c:156: warning: Function parameter
 or member 'inode' not described in 'gfs2_unstuff_inode'
Message-ID: <202310300846.4xot9nPs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git alloc
head:   f8dd6e4dd990a2524b3d76fd2459d027628420eb
commit: 40fddc85a985824fba577aeb19b4f5c2cc8bb34f [52/70] gfs2: Rename gfs2_unstuff_dinode to gfs2_unstuff_inode
config: loongarch-randconfig-002-20231030 (https://download.01.org/0day-ci/archive/20231030/202310300846.4xot9nPs-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310300846.4xot9nPs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310300846.4xot9nPs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/gfs2/bmap.c:156: warning: Function parameter or member 'inode' not described in 'gfs2_unstuff_inode'
>> fs/gfs2/bmap.c:156: warning: Excess function parameter 'ip' description in 'gfs2_unstuff_inode'


vim +156 fs/gfs2/bmap.c

7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  144  
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  145  /**
40fddc85a98582 Andreas Gruenbacher     2023-10-23  146   * gfs2_unstuff_inode - Unstuff an inode when the data has grown too big
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  147   * @ip: The GFS2 inode to unstuff
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  148   *
40fddc85a98582 Andreas Gruenbacher     2023-10-23  149   * This routine unstuffs an inode and returns it to a "normal" state such
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  150   * that the height can be grown in the traditional way.
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  151   *
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  152   * Returns: errno
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  153   */
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  154  
40fddc85a98582 Andreas Gruenbacher     2023-10-23  155  int gfs2_unstuff_inode(struct inode *inode)
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17 @156  {
40fddc85a98582 Andreas Gruenbacher     2023-10-23  157  	struct gfs2_inode *ip = GFS2_I(inode);
2ccec3b8456f65 Matthew Wilcox (Oracle  2023-10-16  158) 	struct folio *folio;
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  159  	int error;
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  160  
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  161  	down_write(&ip->i_rw_mutex);
2ccec3b8456f65 Matthew Wilcox (Oracle  2023-10-16  162) 	folio = filemap_grab_folio(inode->i_mapping, 0);
2ccec3b8456f65 Matthew Wilcox (Oracle  2023-10-16  163) 	error = PTR_ERR(folio);
2ccec3b8456f65 Matthew Wilcox (Oracle  2023-10-16  164) 	if (IS_ERR(folio))
7a607a41cdc6c6 Andreas Gruenbacher     2021-06-17  165  		goto out;
2ccec3b8456f65 Matthew Wilcox (Oracle  2023-10-16  166) 	error = __gfs2_unstuff_inode(ip, folio);
2ccec3b8456f65 Matthew Wilcox (Oracle  2023-10-16  167) 	folio_unlock(folio);
2ccec3b8456f65 Matthew Wilcox (Oracle  2023-10-16  168) 	folio_put(folio);
b3b94faa5fe596 David Teigland          2006-01-16  169  out:
b3b94faa5fe596 David Teigland          2006-01-16  170  	up_write(&ip->i_rw_mutex);
b3b94faa5fe596 David Teigland          2006-01-16  171  	return error;
b3b94faa5fe596 David Teigland          2006-01-16  172  }
b3b94faa5fe596 David Teigland          2006-01-16  173  

:::::: The code at line 156 was first introduced by commit
:::::: 7a607a41cdc6c6f27b8e234cb44ce57070513dac gfs2: Clean up gfs2_unstuff_dinode

:::::: TO: Andreas Gruenbacher <agruenba@redhat.com>
:::::: CC: Andreas Gruenbacher <agruenba@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
