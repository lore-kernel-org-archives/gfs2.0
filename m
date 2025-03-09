Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C52F2A;
	Sun,  9 Mar 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741534808; cv=none; b=NhllC7/o3iPaa+kM6crQN7eHcJqcmPfuGyCOt01LCwOe1lidQ73jxMwF4JFB/T2Ju2RjF71a/z7EfKPDqadMU7BAYNfqb6m9j9GEcUZ46d44h3ThijXVoGwzIyZ+8JwyPXU5M/Qqv3XlWY6cC54JMjf/89tzgn2Fjsw/LBIPjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741534808; c=relaxed/simple;
	bh=WwAgUg82lZpzPyQZQ++FccC8wn2G8XnNw5FLPTqJccs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FEacqYBgRS72goCK6vzMS8mOSpWtRMsmYkwSaxTxhivZP8pcKM22uCGGTDDoHj0C8/BBX2gIq4lycwH/YSpeIAcWlgu1kLTl0G1ehtIzCc1fDQwIcpvJSNP4xfZqb/WhH2LuxS9Nw2JyDWeQo6dTl1ug1WJDhBATLIPngdgsW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNlI8t7u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNlI8t7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741534806; x=1773070806;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WwAgUg82lZpzPyQZQ++FccC8wn2G8XnNw5FLPTqJccs=;
  b=ZNlI8t7uNOnXenqj75yT+u/5A25FTqdaTnFVn+5kKYY052pdd9Fx6IlY
   C4WUFiE6k/OK+UUjzwNOXhj6bgzR3HYgN5qDGE77pSXIBTpiPm1ccrOUt
   DP/ZLfT03qTU6CNz5ui5OgZ1lc/85G5TymxdOPXReR9p2tqx0zaG5+AOF
   5PgoZ1sZbz34b5XTcTCyjrVq5wtEr31yaDL5N1S1LwLw/KAlwodwIVHzA
   b4uppUFOf94rVbuGrkOJ4tog3DSTUDf3kTD7VdRHVQtZLs3iq1OK0rajc
   9kNqnpLx0PxUhuQPPn+UdoGzsN7jF/mD6igDi75RYrLvi5FGSFt2EZIkq
   Q==;
X-CSE-ConnectionGUID: oFM2f12ZSY2hMaFfbGDqGw==
X-CSE-MsgGUID: Z7uujhNBS7ibzsw+hCnsgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="46312409"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="46312409"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 08:40:06 -0700
X-CSE-ConnectionGUID: FgNERcacQiipUGfyLNvmyg==
X-CSE-MsgGUID: AnQ6ODVwS1uW7/jcCYebQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150718075"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 09 Mar 2025 08:40:04 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trIkz-0003Ea-33;
	Sun, 09 Mar 2025 15:40:01 +0000
Date: Sun, 9 Mar 2025 23:39:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [gfs2:for-next 19/20] fs/ocfs2/refcounttree.c:2969:21: error:
 implicit declaration of function 'page_has_buffers'; did you mean
 'inode_has_buffers'?
Message-ID: <202503092318.ztc5Xu3P-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
head:   16abce10ad13ab3ee23754a81164aa8d0506d552
commit: b3cbb48767a2c7a9348b13852b75ea01ed52017b [19/20] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
config: x86_64-buildonly-randconfig-002-20250309 (https://download.01.org/0day-ci/archive/20250309/202503092318.ztc5Xu3P-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503092318.ztc5Xu3P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092318.ztc5Xu3P-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ocfs2/refcounttree.c: In function 'ocfs2_duplicate_clusters_by_page':
>> fs/ocfs2/refcounttree.c:2969:21: error: implicit declaration of function 'page_has_buffers'; did you mean 'inode_has_buffers'? [-Werror=implicit-function-declaration]
    2969 |                 if (page_has_buffers(page)) {
         |                     ^~~~~~~~~~~~~~~~
         |                     inode_has_buffers
   cc1: some warnings being treated as errors
--
   fs/ocfs2/aops.c: In function 'ocfs2_zero_new_buffers':
>> fs/ocfs2/aops.c:878:14: error: implicit declaration of function 'page_has_buffers'; did you mean 'inode_has_buffers'? [-Werror=implicit-function-declaration]
     878 |         if (!page_has_buffers(page))
         |              ^~~~~~~~~~~~~~~~
         |              inode_has_buffers
   cc1: some warnings being treated as errors


vim +2969 fs/ocfs2/refcounttree.c

6f70fa519976a37 Tao Ma                  2009-08-25  2896  
3e19a25e0591a62 Tristan Ye              2011-05-24  2897  int ocfs2_duplicate_clusters_by_page(handle_t *handle,
c7dd3392ad469e6 Tiger Yang              2013-08-13  2898  				     struct inode *inode,
6f70fa519976a37 Tao Ma                  2009-08-25  2899  				     u32 cpos, u32 old_cluster,
6f70fa519976a37 Tao Ma                  2009-08-25  2900  				     u32 new_cluster, u32 new_len)
6f70fa519976a37 Tao Ma                  2009-08-25  2901  {
6f70fa519976a37 Tao Ma                  2009-08-25  2902  	int ret = 0, partial;
c7dd3392ad469e6 Tiger Yang              2013-08-13  2903  	struct super_block *sb = inode->i_sb;
6f70fa519976a37 Tao Ma                  2009-08-25  2904  	u64 new_block = ocfs2_clusters_to_blocks(sb, new_cluster);
6f70fa519976a37 Tao Ma                  2009-08-25  2905  	struct page *page;
6f70fa519976a37 Tao Ma                  2009-08-25  2906  	pgoff_t page_index;
262d8a8779e2459 Joseph Qi               2015-11-05  2907  	unsigned int from, to;
6f70fa519976a37 Tao Ma                  2009-08-25  2908  	loff_t offset, end, map_end;
3e19a25e0591a62 Tristan Ye              2011-05-24  2909  	struct address_space *mapping = inode->i_mapping;
6f70fa519976a37 Tao Ma                  2009-08-25  2910  
198aac283873169 Tao Ma                  2011-02-22  2911  	trace_ocfs2_duplicate_clusters_by_page(cpos, old_cluster,
198aac283873169 Tao Ma                  2011-02-22  2912  					       new_cluster, new_len);
6f70fa519976a37 Tao Ma                  2009-08-25  2913  
6f70fa519976a37 Tao Ma                  2009-08-25  2914  	offset = ((loff_t)cpos) << OCFS2_SB(sb)->s_clustersize_bits;
6f70fa519976a37 Tao Ma                  2009-08-25  2915  	end = offset + (new_len << OCFS2_SB(sb)->s_clustersize_bits);
f5e27b6ddfbafdd Tao Ma                  2010-07-14  2916  	/*
f5e27b6ddfbafdd Tao Ma                  2010-07-14  2917  	 * We only duplicate pages until we reach the page contains i_size - 1.
f5e27b6ddfbafdd Tao Ma                  2010-07-14  2918  	 * So trim 'end' to i_size.
f5e27b6ddfbafdd Tao Ma                  2010-07-14  2919  	 */
3e19a25e0591a62 Tristan Ye              2011-05-24  2920  	if (end > i_size_read(inode))
3e19a25e0591a62 Tristan Ye              2011-05-24  2921  		end = i_size_read(inode);
6f70fa519976a37 Tao Ma                  2009-08-25  2922  
6f70fa519976a37 Tao Ma                  2009-08-25  2923  	while (offset < end) {
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  2924  		page_index = offset >> PAGE_SHIFT;
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  2925  		map_end = ((loff_t)page_index + 1) << PAGE_SHIFT;
6f70fa519976a37 Tao Ma                  2009-08-25  2926  		if (map_end > end)
6f70fa519976a37 Tao Ma                  2009-08-25  2927  			map_end = end;
6f70fa519976a37 Tao Ma                  2009-08-25  2928  
6f70fa519976a37 Tao Ma                  2009-08-25  2929  		/* from, to is the offset within the page. */
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  2930  		from = offset & (PAGE_SIZE - 1);
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  2931  		to = PAGE_SIZE;
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  2932  		if (map_end & (PAGE_SIZE - 1))
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  2933  			to = map_end & (PAGE_SIZE - 1);
6f70fa519976a37 Tao Ma                  2009-08-25  2934  
69eb7765b9c6902 Larry Chen              2018-10-05  2935  retry:
9b4c0ff32ccd87a Jan Kara                2010-08-24  2936  		page = find_or_create_page(mapping, page_index, GFP_NOFS);
62c610460d73fcf Gu Zheng                2013-07-31  2937  		if (!page) {
62c610460d73fcf Gu Zheng                2013-07-31  2938  			ret = -ENOMEM;
62c610460d73fcf Gu Zheng                2013-07-31  2939  			mlog_errno(ret);
62c610460d73fcf Gu Zheng                2013-07-31  2940  			break;
62c610460d73fcf Gu Zheng                2013-07-31  2941  		}
6f70fa519976a37 Tao Ma                  2009-08-25  2942  
0a1ea437d87af83 Tao Ma                  2010-02-01  2943  		/*
69eb7765b9c6902 Larry Chen              2018-10-05  2944  		 * In case PAGE_SIZE <= CLUSTER_SIZE, we do not expect a dirty
69eb7765b9c6902 Larry Chen              2018-10-05  2945  		 * page, so write it back.
0a1ea437d87af83 Tao Ma                  2010-02-01  2946  		 */
69eb7765b9c6902 Larry Chen              2018-10-05  2947  		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize) {
69eb7765b9c6902 Larry Chen              2018-10-05  2948  			if (PageDirty(page)) {
8e4bfd136410df7 Christoph Hellwig       2023-01-18  2949  				unlock_page(page);
8e4bfd136410df7 Christoph Hellwig       2023-01-18  2950  				put_page(page);
8e4bfd136410df7 Christoph Hellwig       2023-01-18  2951  
8e4bfd136410df7 Christoph Hellwig       2023-01-18  2952  				ret = filemap_write_and_wait_range(mapping,
8e4bfd136410df7 Christoph Hellwig       2023-01-18  2953  						offset, map_end - 1);
69eb7765b9c6902 Larry Chen              2018-10-05  2954  				goto retry;
69eb7765b9c6902 Larry Chen              2018-10-05  2955  			}
69eb7765b9c6902 Larry Chen              2018-10-05  2956  		}
6f70fa519976a37 Tao Ma                  2009-08-25  2957  
6f70fa519976a37 Tao Ma                  2009-08-25  2958  		if (!PageUptodate(page)) {
2c69e2057962b6b Matthew Wilcox (Oracle  2022-04-29  2959) 			struct folio *folio = page_folio(page);
2c69e2057962b6b Matthew Wilcox (Oracle  2022-04-29  2960) 
2c69e2057962b6b Matthew Wilcox (Oracle  2022-04-29  2961) 			ret = block_read_full_folio(folio, ocfs2_get_block);
6f70fa519976a37 Tao Ma                  2009-08-25  2962  			if (ret) {
6f70fa519976a37 Tao Ma                  2009-08-25  2963  				mlog_errno(ret);
6f70fa519976a37 Tao Ma                  2009-08-25  2964  				goto unlock;
6f70fa519976a37 Tao Ma                  2009-08-25  2965  			}
2c69e2057962b6b Matthew Wilcox (Oracle  2022-04-29  2966) 			folio_lock(folio);
6f70fa519976a37 Tao Ma                  2009-08-25  2967  		}
6f70fa519976a37 Tao Ma                  2009-08-25  2968  
6f70fa519976a37 Tao Ma                  2009-08-25 @2969  		if (page_has_buffers(page)) {
6f70fa519976a37 Tao Ma                  2009-08-25  2970  			ret = walk_page_buffers(handle, page_buffers(page),
6f70fa519976a37 Tao Ma                  2009-08-25  2971  						from, to, &partial,
6f70fa519976a37 Tao Ma                  2009-08-25  2972  						ocfs2_clear_cow_buffer);
6f70fa519976a37 Tao Ma                  2009-08-25  2973  			if (ret) {
6f70fa519976a37 Tao Ma                  2009-08-25  2974  				mlog_errno(ret);
6f70fa519976a37 Tao Ma                  2009-08-25  2975  				goto unlock;
6f70fa519976a37 Tao Ma                  2009-08-25  2976  			}
6f70fa519976a37 Tao Ma                  2009-08-25  2977  		}
6f70fa519976a37 Tao Ma                  2009-08-25  2978  
c7dd3392ad469e6 Tiger Yang              2013-08-13  2979  		ocfs2_map_and_dirty_page(inode,
c7dd3392ad469e6 Tiger Yang              2013-08-13  2980  					 handle, from, to,
6f70fa519976a37 Tao Ma                  2009-08-25  2981  					 page, 0, &new_block);
6f70fa519976a37 Tao Ma                  2009-08-25  2982  		mark_page_accessed(page);
6f70fa519976a37 Tao Ma                  2009-08-25  2983  unlock:
6f70fa519976a37 Tao Ma                  2009-08-25  2984  		unlock_page(page);
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  2985  		put_page(page);
6f70fa519976a37 Tao Ma                  2009-08-25  2986  		page = NULL;
6f70fa519976a37 Tao Ma                  2009-08-25  2987  		offset = map_end;
6f70fa519976a37 Tao Ma                  2009-08-25  2988  		if (ret)
6f70fa519976a37 Tao Ma                  2009-08-25  2989  			break;
6f70fa519976a37 Tao Ma                  2009-08-25  2990  	}
6f70fa519976a37 Tao Ma                  2009-08-25  2991  
6f70fa519976a37 Tao Ma                  2009-08-25  2992  	return ret;
6f70fa519976a37 Tao Ma                  2009-08-25  2993  }
6f70fa519976a37 Tao Ma                  2009-08-25  2994  

:::::: The code at line 2969 was first introduced by commit
:::::: 6f70fa519976a379d72781d927cf8e5f5b05ec86 ocfs2: Add CoW support.

:::::: TO: Tao Ma <tao.ma@oracle.com>
:::::: CC: Joel Becker <joel.becker@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
