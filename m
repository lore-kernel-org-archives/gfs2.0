Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D548425A;
	Tue,  4 Aug 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873296; cv=none; b=k0uCyCXNH3B+6lxNLWcLwt+zQHB3VLhgTUYqPB3nuT0d/cikkD9mKezeK6ZC/XeWipuCEPHPHZLXAz2fD7ut0wEdl9XJx5LRKbH00DtQhDIBKAZtWHHcrQjA5Cs0H7OyfPeejDYu+fQO9mP7h3sz0aD2pkgunvLjhQ9lfRi6rJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873296; c=relaxed/simple;
	bh=zZqZKcAftzj8ITm91foSLDbylWN9INMq1B6IOolVLq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZJ9h2at4N5sMmcIKvD6l0zBCJuzJytBQ52pwmAD+Winqai6GFXe1VJzJB6XlX+DmpC9hcjeX9IkMcPnB5A0XlfTF+mbwOGASVJFhS64ARVEsKFh3BWtkgflw16G7wEs402VdKbVTQ5YUiGH4BlL1yaRIMcNmMbKV/PYhvS3Q2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8JUQ28x; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8JUQ28x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785873290; x=1817409290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zZqZKcAftzj8ITm91foSLDbylWN9INMq1B6IOolVLq4=;
  b=A8JUQ28x3z2Mkg3us+vv1JuA/mMDDEPBmjDuXab0ehiSDVUYVLdrp/BN
   bl4L5SnjYkzq48PAkaLVfBOUm06tjVfx897H05RxBB255iTB4pUG8zCO3
   e9RQHUFuM6kYLG8RebRbgQCV8707yLbNhMqUVVqphXM14Y2tLZkVfDwFN
   FsRqgdYsDwIZV8UZDY6RqFNltGGXvcKAqLWcEuPRPYQc3ME5SucEfEhCI
   W8d1aXC0rA8oIz9DVY/XeLZ7M1sjyNEernAjo3vAna1h2/ghfZb7hNxqi
   bF4iZzzxM73NBKUdQjuOj2Xlz5J6zPrQdsuty+U1uA4yo+zMqmOknifUT
   w==;
X-CSE-ConnectionGUID: gQLVqH4gSKKjW7e3n1TaCQ==
X-CSE-MsgGUID: bB3MxnhCRoaLYumge48/AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86291056"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86291056"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 12:54:49 -0700
X-CSE-ConnectionGUID: k/SqPiR/QrqTxbEfv8vGYw==
X-CSE-MsgGUID: CWpv8vWSSMWsAvNAIgVtvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="261659357"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Aug 2026 12:54:46 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrLDo-00000000AbZ-0isV;
	Tue, 04 Aug 2026 19:54:44 +0000
Date: Wed, 5 Aug 2026 03:53:59 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian <adriangarciacasado42@gmail.com>, gfs2@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
Message-ID: <202608050308.IDO5tJxh-lkp@intel.com>
References: <6a344397.561280e1.325e99.aabf@mx.google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a344397.561280e1.325e99.aabf@mx.google.com>

Hi Adrian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on gfs2/for-next]
[also build test WARNING on linus/master v7.2-rc6 next-20260804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian/gfs2-add-missing-__rcu-annotation-to-i_gl-in-incore-h/20260804-040145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
patch link:    https://lore.kernel.org/r/6a344397.561280e1.325e99.aabf%40mx.google.com
patch subject: [PATCH] gfs2: add missing __rcu annotation to i_gl in incore.h
config: nios2-randconfig-r132-20260804 (https://download.01.org/0day-ci/archive/20260805/202608050308.IDO5tJxh-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608050308.IDO5tJxh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608050308.IDO5tJxh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/gfs2/export.c:112:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/export.c:112:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/export.c:112:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/acl.c:70:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/acl.c:70:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/acl.c:70:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/acl.c:71:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/acl.c:71:48: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/acl.c:71:48: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/acl.c:122:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/acl.c:122:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/acl.c:122:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/acl.c:123:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/acl.c:123:44: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/acl.c:123:44: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/dentry.c:60:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dentry.c:60:51: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dentry.c:60:51: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dentry.c:62:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dentry.c:62:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dentry.c:62:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/util.c:61:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/util.c:61:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/util.c:61:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/util.c:345:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/util.c:345:33: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/util.c:345:33: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/recovery.c:36:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/recovery.c:36:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/recovery.c:36:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/recovery.c:348:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/recovery.c:348:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/recovery.c:348:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/recovery.c:443:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/recovery.c:443:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/recovery.c:443:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/meta_io.c:416:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/meta_io.c:416:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/meta_io.c:416:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/meta_io.c:451:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/meta_io.c:451:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/meta_io.c:451:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/aops.c:114:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/aops.c:114:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/aops.c:114:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/aops.c:371:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/aops.c:371:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/aops.c:371:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/aops.c:569:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/aops.c:569:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/aops.c:569:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/aops.c:135:13: sparse: sparse: dereference of noderef expression
--
>> fs/gfs2/glops.c:606:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *j_gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/glops.c:606:37: sparse:     expected struct gfs2_glock *j_gl
   fs/gfs2/glops.c:606:37: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/xattr.c:135:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:135:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:135:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:159:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:159:42: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:159:42: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:282:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:282:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:282:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:429:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:429:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:429:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:475:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:475:42: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:475:42: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:508:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:508:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:508:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:617:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:617:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:617:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:618:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:618:44: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:618:44: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:650:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:650:32: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:650:32: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:651:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:651:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:651:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:712:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:712:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:712:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:713:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:713:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:713:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:848:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:848:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:848:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:885:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:885:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:885:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:909:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:909:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:909:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:983:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:983:42: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:983:42: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1005:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1005:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1005:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1013:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1013:41: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1013:41: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1014:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1014:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1014:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1099:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1099:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1099:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1247:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1247:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1247:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1248:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1248:44: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1248:44: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1286:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1286:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1286:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1336:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1336:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1336:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1370:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1370:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1370:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/xattr.c:1422:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/xattr.c:1422:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/xattr.c:1422:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/xattr.c:1252:21: sparse: sparse: dereference of noderef expression
--
>> fs/gfs2/dir.c:95:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:95:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:95:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:96:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:96:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:96:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:109:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:109:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:109:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:130:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:130:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:130:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:211:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:211:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:211:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:233:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:233:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:233:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:302:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:302:45: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:302:45: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:304:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:304:50: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:304:50: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:682:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:682:32: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:682:32: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:721:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:721:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:721:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:764:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:764:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:764:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:878:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:878:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:878:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:883:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:883:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:883:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:971:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:971:32: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:971:32: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:1028:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:1028:32: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:1028:32: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:1121:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:1121:40: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:1121:40: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/dir.c:1484:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:1484:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:1484:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:1748:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:1748:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:1748:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:1763:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:1763:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:1763:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:1949:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:1949:32: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:1949:32: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/dir.c:2069:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/dir.c:2069:32: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/dir.c:2069:32: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/lops.c:780:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/lops.c:780:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/lops.c:780:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/lops.c:835:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/lops.c:835:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/lops.c:835:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/lops.c:841:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/lops.c:841:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/lops.c:841:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/lops.c:1004:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/lops.c:1004:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/lops.c:1004:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/lops.c:1055:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/lops.c:1055:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/lops.c:1055:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/lops.c:1062:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/lops.c:1062:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/lops.c:1062:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/bmap.c:1834:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1834:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1834:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1954:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1954:60: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1954:60: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1989:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1989:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1989:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:81:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:81:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:81:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:127:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:127:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:127:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:681:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:681:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:681:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:725:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:725:58: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:725:58: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:751:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:751:55: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:751:55: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:753:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:753:58: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:753:58: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:763:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:763:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:763:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:996:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:996:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:996:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/bmap.c:1199:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long volatile *addr @@     got unsigned long [noderef] __rcu * @@
   fs/gfs2/bmap.c:1199:31: sparse:     expected unsigned long volatile *addr
   fs/gfs2/bmap.c:1199:31: sparse:     got unsigned long [noderef] __rcu *
   fs/gfs2/bmap.c:1416:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1416:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1416:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1588:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1588:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1588:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1622:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:1622:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:1622:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:2034:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:2034:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:2034:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:2139:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:2139:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:2139:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:2390:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/bmap.c:2390:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/bmap.c:2390:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/bmap.c:1708:42: sparse: sparse: unsigned value that used to be signed checked against zero?
   fs/gfs2/bmap.c:2006:16: sparse: signed value source
--
>> fs/gfs2/rgrp.c:1037:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/rgrp.c:1037:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/rgrp.c:1037:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/rgrp.c:2456:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/rgrp.c:2456:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/rgrp.c:2456:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/super.c:136:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *j_gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:136:37: sparse:     expected struct gfs2_glock *j_gl
   fs/gfs2/super.c:136:37: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/super.c:186:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:186:40: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:186:40: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:225:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:225:33: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:225:33: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:252:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:252:33: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:252:33: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:253:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:253:33: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:253:33: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:276:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:276:40: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:276:40: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:345:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:345:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:345:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:443:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:443:65: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:443:65: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:449:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:449:50: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:449:50: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:498:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:498:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:498:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:499:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:499:44: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:499:44: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:502:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:502:49: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:502:49: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:520:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:520:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:520:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1212:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1212:9: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1212:9: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1212:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1212:9: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1212:9: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1212:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1212:9: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1212:9: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1218:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1218:42: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1218:42: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1258:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1258:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1258:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1262:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1262:42: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1262:42: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/super.c:1292:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1292:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1292:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1394:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1394:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1394:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1509:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1509:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1509:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/super.c:1511:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/super.c:1511:45: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/super.c:1511:45: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/super.c:506:20: sparse: sparse: dereference of noderef expression
--
>> fs/gfs2/inode.c:150:41: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected struct gfs2_glock **glp @@     got struct gfs2_glock [noderef] __rcu ** @@
   fs/gfs2/inode.c:150:41: sparse:     expected struct gfs2_glock **glp
   fs/gfs2/inode.c:150:41: sparse:     got struct gfs2_glock [noderef] __rcu **
>> fs/gfs2/inode.c:181:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:181:54: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:181:54: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:188:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:188:58: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:188:58: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/inode.c:199:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long volatile *addr @@     got unsigned long [noderef] __rcu * @@
   fs/gfs2/inode.c:199:52: sparse:     expected unsigned long volatile *addr
   fs/gfs2/inode.c:199:52: sparse:     got unsigned long [noderef] __rcu *
   fs/gfs2/inode.c:206:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:206:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:206:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:212:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:212:54: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:212:54: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:244:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:244:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:244:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:342:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:342:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:342:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:343:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:343:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:343:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/inode.c:459:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:459:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:459:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:553:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:553:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:553:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:554:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:554:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:554:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:580:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:580:32: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:580:32: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:581:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:581:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:581:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:729:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:729:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:729:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:835:80: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected struct gfs2_glock **glp @@     got struct gfs2_glock [noderef] __rcu ** @@
   fs/gfs2/inode.c:835:80: sparse:     expected struct gfs2_glock **glp
   fs/gfs2/inode.c:835:80: sparse:     got struct gfs2_glock [noderef] __rcu **
   fs/gfs2/inode.c:857:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:857:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:857:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:860:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long volatile *addr @@     got unsigned long [noderef] __rcu * @@
   fs/gfs2/inode.c:860:46: sparse:     expected unsigned long volatile *addr
   fs/gfs2/inode.c:860:46: sparse:     got unsigned long [noderef] __rcu *
   fs/gfs2/inode.c:873:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:873:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:873:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:917:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:917:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:917:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:936:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:936:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:936:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/inode.c:1000:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1000:12: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1000:12: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1060:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1060:29: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1060:29: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1061:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1061:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1061:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1134:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1134:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1134:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1260:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1260:29: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1260:29: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1261:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1261:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1261:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1535:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1535:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1535:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1537:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1537:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1537:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1541:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1541:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1541:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1545:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1545:37: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1545:37: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1781:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1781:30: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1781:30: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1783:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1783:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1783:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1787:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1787:29: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1787:29: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1790:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1790:29: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1790:29: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:1921:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:1921:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:1921:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:2111:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:2111:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:2111:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:2171:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:2171:42: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:2171:42: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:2172:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:2172:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:2172:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:2215:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:2215:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:2215:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:2243:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:2243:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:2243:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:2262:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:2262:36: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:2262:36: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/inode.c:2277:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/inode.c:2277:35: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/inode.c:2277:35: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/ops_fstype.c:548:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/ops_fstype.c:548:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/ops_fstype.c:548:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/ops_fstype.c:660:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/ops_fstype.c:660:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/ops_fstype.c:660:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/ops_fstype.c:755:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/ops_fstype.c:755:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/ops_fstype.c:755:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/ops_fstype.c:924:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/ops_fstype.c:924:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/ops_fstype.c:924:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/file.c:66:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:66:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:66:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:112:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:112:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:112:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:169:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:169:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:169:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:228:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:228:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:228:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:245:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:245:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:245:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:265:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:265:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:265:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:433:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:433:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:433:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/file.c:458:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long volatile *addr @@     got unsigned long [noderef] __rcu * @@
   fs/gfs2/file.c:458:31: sparse:     expected unsigned long volatile *addr
   fs/gfs2/file.c:458:31: sparse:     got unsigned long [noderef] __rcu *
   fs/gfs2/file.c:560:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:560:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:560:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:600:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:600:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:600:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:683:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:683:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:683:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:770:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:770:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:770:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:840:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:840:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:840:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:903:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:903:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:903:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:983:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:983:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:983:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1037:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1037:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1037:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1054:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1054:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1054:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1115:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1115:44: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1115:44: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1192:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1192:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1192:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/file.c:1393:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/file.c:1393:28: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/file.c:1393:28: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
--
>> fs/gfs2/quota.c:437:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/quota.c:437:34: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/quota.c:437:34: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/quota.c:695:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/quota.c:695:31: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/quota.c:695:31: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/quota.c:783:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/quota.c:783:39: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/quota.c:783:39: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/quota.c:938:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/quota.c:938:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/quota.c:938:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/quota.c:996:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/quota.c:996:47: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/quota.c:996:47: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/quota.c:1065:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/quota.c:1065:46: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/quota.c:1065:46: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/quota.c:1442:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/quota.c:1442:37: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/quota.c:1442:37: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
   fs/gfs2/quota.c:1748:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/quota.c:1748:38: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/quota.c:1748:38: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl
>> fs/gfs2/quota.c:996:24: sparse: sparse: dereference of noderef expression
--
>> fs/gfs2/glock.c:894:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct gfs2_glock *gl @@     got struct gfs2_glock [noderef] __rcu *i_gl @@
   fs/gfs2/glock.c:894:43: sparse:     expected struct gfs2_glock *gl
   fs/gfs2/glock.c:894:43: sparse:     got struct gfs2_glock [noderef] __rcu *i_gl

vim +112 fs/gfs2/export.c

b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   84  
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   85  static int gfs2_get_name(struct dentry *parent, char *name,
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   86  			 struct dentry *child)
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   87  {
2b0143b5c986be1 fs/gfs2/export.c     David Howells     2015-03-17   88  	struct inode *dir = d_inode(parent);
2b0143b5c986be1 fs/gfs2/export.c     David Howells     2015-03-17   89  	struct inode *inode = d_inode(child);
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   90  	struct gfs2_inode *dip, *ip;
ac6614b76478e68 fs/gfs2/export.c     Al Viro           2013-05-22   91  	struct get_name_filldir gnfd = {
ac6614b76478e68 fs/gfs2/export.c     Al Viro           2013-05-22   92  		.ctx.actor = get_name_filldir,
ac6614b76478e68 fs/gfs2/export.c     Al Viro           2013-05-22   93  		.name = name
ac6614b76478e68 fs/gfs2/export.c     Al Viro           2013-05-22   94  	};
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   95  	struct gfs2_holder gh;
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   96  	int error;
dfe4d34b39b80fa fs/gfs2/export.c     Bob Peterson      2011-10-27   97  	struct file_ra_state f_ra = { .start = 0 };
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   98  
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16   99  	if (!dir)
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  100  		return -EINVAL;
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  101  
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  102  	if (!S_ISDIR(dir->i_mode) || !inode)
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  103  		return -EINVAL;
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  104  
feaa7bba026c181 fs/gfs2/ops_export.c Steven Whitehouse 2006-06-14  105  	dip = GFS2_I(dir);
feaa7bba026c181 fs/gfs2/ops_export.c Steven Whitehouse 2006-06-14  106  	ip = GFS2_I(inode);
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  107  
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  108  	*name = 0;
dbb7cae2a36170c fs/gfs2/ops_export.c Steven Whitehouse 2007-05-15  109  	gnfd.inum.no_addr = ip->i_no_addr;
dbb7cae2a36170c fs/gfs2/ops_export.c Steven Whitehouse 2007-05-15  110  	gnfd.inum.no_formal_ino = ip->i_no_formal_ino;
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  111  
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16 @112  	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &gh);
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  113  	if (error)
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  114  		return error;
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  115  
d81a8ef59802d2d fs/gfs2/export.c     Al Viro           2013-05-16  116  	error = gfs2_dir_read(dir, &gnfd.ctx, &f_ra);
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  117  
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  118  	gfs2_glock_dq_uninit(&gh);
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  119  
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  120  	if (!error && !*name)
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  121  		error = -ENOENT;
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  122  
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  123  	return error;
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  124  }
b3b94faa5fe5968 fs/gfs2/ops_export.c David Teigland    2006-01-16  125  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
