Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [116.203.65.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A43B1A4
	for <gfs2@lists.linux.dev>; Sun, 10 Mar 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.65.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710107813; cv=none; b=hmudd9CuSKlZcvJTnu3cAjSabKF4uv1HnKhgLvbS3jDPau+wvJ9GvAs1YThGq1XlUWo7Y5H7uDRvdcxe87ksDpIdOC4MK9vRdShXV8J+O/tVkw4kHpIEf2MgsraFZVwTMCaRnLXv2sN+XhLR34SfXlhn6oLABLjPV1LT2PECNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710107813; c=relaxed/simple;
	bh=tzsGVJ2OU/UC5/2pdyK8Q+myamsUQp42QmeXWRnzTdA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iCdOcFQ/OzI/4aAtDzpIeKxu+AVv/719/Ol9C5teTJBkCO+hH9wN3lhHXBTVeQKy3hfXM7OnJQTHOnCikc8/Ax/x5b7MG0XyoMMuYZvKMQPh2q1WUMqtL9TK5jceMFvQ+KVIAMh29hIEdA4E+gD2TpLfWuiQne5j6fZRZIca4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr; spf=pass smtp.mailfrom=valentin-vidic.from.hr; dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b=v461m/9a; arc=none smtp.client-ip=116.203.65.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="v461m/9a"
X-Virus-Scanned: Debian amavis at valentin-vidic.from.hr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=valentin-vidic.from.hr; s=2020; t=1710107210;
	bh=tzsGVJ2OU/UC5/2pdyK8Q+myamsUQp42QmeXWRnzTdA=;
	h=Date:From:To:Subject:From;
	b=v461m/9a+KJQeQ0RShB1Gn3Od2gr/VrUt2zKL/dTgqQD+/+UhMm5X/nSqIT5FCru3
	 uClVBHEB7Dfl3BsNc2y+gxmJgreZBFsOJj9LFwAM3fg5CegUDkU6Jw4KpKMgVPGb4G
	 QS6ZcsV5pMRkRSA9VQazb58qS2fmtuD4gIY7qOk7ITFXbeHfKCiAkW/jMjNTgaYfDU
	 fX+tcTCFv3uY9iueqSW8OMzef+vJ30eAm9n7jZocRKdj6bSv5cgR9niybnALf0RZUk
	 vtgq29riusRxH3dUXZnu5W66W99iZt4t9jLUMHS+A06zZyPHBH3bTNf88m3TqyfIiz
	 xnKw1QsAH5qGfjRMfLvF/e6mMw2DvfTP5uDDMCS6tG0SqiUrNCb6OpSGnZ0+GNZK2m
	 wsLZ9QyiUs7uosD3KmYYnnpWRdqNakhLACf1+wH06NPqX2cJnWn9/ehaUadCgrcVqg
	 MWoWNz0ctooKR259iXy4ROuICcj2vlW6VS4jSaJx8173D8Gi2iIKZj8WQV31Qm5sj5
	 xPla9uMTAPLtbGYrLG/Q86bNLNaigJVU+nlQcdNTIy3WflLNH66lFpjBxEb1Zup1IX
	 YqvZPcV7t4JBi2wYk94Hg4ppVfSeCTPk22lmlIIrt9mdTo+0n94uh2h35jJIQKHO7/
	 QeF8muqZD1WnLfF7lqpILjJo=
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
	id 5D6742D276; Sun, 10 Mar 2024 22:46:50 +0100 (CET)
Date: Sun, 10 Mar 2024 22:46:50 +0100
From: Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To: ocfs2-devel@oss.oracle.com, Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev
Subject: ocfs2 mount error
Message-ID: <Ze4qSvzGJDt5yxC3@valentin-vidic.from.hr>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've started seeing the following mount error on recent kernels (6.7, 6.8)
while the same script worked on older versions (6.1):

2024-03-10T21:04:30,623900+00:00 ocfs2: Registered cluster interface user
2024-03-10T21:04:30,627545+00:00 ocfs2: Unable to create the lockspace D6DCCE389FC84C8FB9E99ABE1D941825 (-17), because a ocfs2-tools program is running on this file system with the same name lockspace
2024-03-10T21:04:30,630607+00:00 (mount.ocfs2,1577,0):ocfs2_dlm_init:3357 ERROR: status = -17
2024-03-10T21:04:30,633153+00:00 (mount.ocfs2,1577,0):ocfs2_mount_volume:1791 ERROR: status = -17
2024-03-10T21:04:30,634947+00:00 (mount.ocfs2,1577,0):ocfs2_fill_super:1176 ERROR: status = -17

Script runs the commands in the following order:

mkfs.ocfs2
fsck.ocfs2
mount.ocfs2

fsck command tries to release the lockspace but it seems to be busy so
it stays around and the mount command fails. Running dlm_tool leave
manually removes it and after that the mount command works again. 

A git bisect has led me to the following change:

61bed0baa4dba17dd06cdfe20481a580718d6c7c fs: dlm: use a non-static queue for callbacks

Could it be that some callback does not run correctly causing the lockspace
to be busy? I have added some more debug info below including some logging of
5 kref_get and 4 kref_put that could be related.

# dlm_tool ls   
dlm lockspaces
name          D6DCCE389FC84C8FB9E99ABE1D941825
id            0x3a105115
flags         0x00000000 
change        member 1 joined 1 remove 0 failed 0 seq 1,1
members       1 

# dlm_tool status D6DCCE389FC84C8FB9E99ABE1D941825
cluster nodeid 1 quorate 1 ring seq 5 5
daemon now 1831 fence_pid 0 
node 1 M add 54 rem 0 fail 0 fence 0 at 0 0

/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Resource 0000000020c29d80 Name (len=31) "S000000000000000000000200000000"
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Master Copy
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:LVB: 6f ec 98 7c e3 55 00 00 ef fb ff 7f fe ff ff ff 
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:     df 11 59 d4 a4 7f 00 00 60 39 dc 7c e3 55 00 00 
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Granted Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Conversion Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Waiting Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Resource 000000003cfd484e Name (len=17) ".5f5b44890bdfac21"
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Master Copy
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Granted Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Conversion Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Waiting Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Resource 00000000c8e96ac4 Name (len=31) "M0000000000000000000018fe4c9cda"
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Master Copy
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:LVB: 00 00 00 00 00 00 00 00 00 68 df 7c e3 55 00 00 
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:     b0 01 6f d4 a4 7f 00 00 e0 46 9d 7c e3 55 00 00 
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Granted Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Conversion Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Waiting Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Resource 000000004c006d70 Name (len=31) "M0000000000000000000019fe4c9cda"
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Master Copy
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:LVB: 00 00 00 00 00 00 00 00 00 7c df 7c e3 55 00 00 
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:     b0 01 6f d4 a4 7f 00 00 e0 46 9d 7c e3 55 00 00 
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Granted Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Conversion Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825:Waiting Queue
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_all:rsb ptr nodeid first_lkid flags !root_list_empty !recover_list_empty recover_locks_count len
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_all:rsb 0000000020c29d80 0 0 0 0 0 0 31 str S000000000000000000000200000000
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_all:lvb 1 32 6f ec 98 7c e3 55 00 00 ef fb ff 7f fe ff ff ff df 11 59 d4 a4 7f 00 00 60 39 dc 7c e3 55 00 00
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_all:rsb 000000003cfd484e 0 0 0 0 0 0 17 str .5f5b44890bdfac21
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_all:rsb 00000000c8e96ac4 0 0 0 0 0 0 31 str M0000000000000000000018fe4c9cda
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_all:lvb 1 32 00 00 00 00 00 00 00 00 00 68 df 7c e3 55 00 00 b0 01 6f d4 a4 7f 00 00 e0 46 9d 7c e3 55 00 00
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_all:rsb 000000004c006d70 0 0 0 0 0 0 31 str M0000000000000000000019fe4c9cda
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_all:lvb 1 32 00 00 00 00 00 00 00 00 00 7c df 7c e3 55 00 00 b0 01 6f d4 a4 7f 00 00 e0 46 9d 7c e3 55 00 00
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_locks:id nodeid remid pid xid exflags flags sts grmode rqmode time_ms r_nodeid r_len r_name
/sys/kernel/debug/dlm/D6DCCE389FC84C8FB9E99ABE1D941825_queued_asts:lkb_id lkb_flags mode flags sb_status sb_flags

2024-03-10T21:04:29,431465+00:00 dlm: kref_get 1
2024-03-10T21:04:29,432585+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:29,434951+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:29,436839+00:00 Call Trace:
2024-03-10T21:04:29,437077+00:00  <TASK>
2024-03-10T21:04:29,437308+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:29,437653+00:00  add_lkb+0x2f/0x300 [dlm]
2024-03-10T21:04:29,438000+00:00  ? rsb_insert+0x85/0xd0 [dlm]
2024-03-10T21:04:29,438378+00:00  _grant_lock+0x111/0x170 [dlm]
2024-03-10T21:04:29,438756+00:00  do_request+0x71/0x90 [dlm]
2024-03-10T21:04:29,439112+00:00  _request_lock+0x19b/0x270 [dlm]
2024-03-10T21:04:29,439509+00:00  request_lock+0xc7/0x110 [dlm]
2024-03-10T21:04:29,439887+00:00  dlm_user_request+0x10d/0x370 [dlm]
2024-03-10T21:04:29,440304+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:29,440763+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:29,441161+00:00  ? __pfx_fake_astfn+0x10/0x10 [dlm]
2024-03-10T21:04:29,441578+00:00  ? __pfx_fake_bastfn+0x10/0x10 [dlm]
2024-03-10T21:04:29,442016+00:00  device_write+0x5f1/0x790 [dlm]
2024-03-10T21:04:29,442413+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:29,442723+00:00  ? __x64_sys_fcntl+0x90/0xc0
2024-03-10T21:04:29,443082+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:29,443389+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:29,443729+00:00  ? exc_page_fault+0x73/0x170
2024-03-10T21:04:29,444086+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76

2024-03-10T21:04:29,453050+00:00 dlm: kref_get 1
2024-03-10T21:04:29,453556+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:29,454373+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:29,455462+00:00 Call Trace:
2024-03-10T21:04:29,455922+00:00  <TASK>
2024-03-10T21:04:29,456345+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:29,456903+00:00  dlm_user_add_ast+0x1fc/0x300 [dlm]
2024-03-10T21:04:29,457548+00:00  do_request+0x7b/0x90 [dlm]
2024-03-10T21:04:29,458128+00:00  _request_lock+0x19b/0x270 [dlm]
2024-03-10T21:04:29,458771+00:00  request_lock+0xc7/0x110 [dlm]
2024-03-10T21:04:29,459375+00:00  dlm_user_request+0x10d/0x370 [dlm]
2024-03-10T21:04:29,460021+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:29,460714+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:29,461363+00:00  ? __pfx_fake_astfn+0x10/0x10 [dlm]
2024-03-10T21:04:29,462003+00:00  ? __pfx_fake_bastfn+0x10/0x10 [dlm]
2024-03-10T21:04:29,462659+00:00  device_write+0x5f1/0x790 [dlm]
2024-03-10T21:04:29,463268+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:29,463791+00:00  ? __x64_sys_fcntl+0x90/0xc0
2024-03-10T21:04:29,464359+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:29,464891+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:29,465440+00:00  ? exc_page_fault+0x73/0x170
2024-03-10T21:04:29,466005+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76

2024-03-10T21:04:29,475107+00:00 dlm: kref_get 1
2024-03-10T21:04:29,475617+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:29,476460+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:29,477545+00:00 Call Trace:
2024-03-10T21:04:29,478031+00:00  <TASK>
2024-03-10T21:04:29,478494+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:29,479094+00:00  dlm_user_request+0x299/0x370 [dlm]
2024-03-10T21:04:29,479787+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:29,480544+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:29,481195+00:00  ? __pfx_fake_astfn+0x10/0x10 [dlm]
2024-03-10T21:04:29,481848+00:00  ? __pfx_fake_bastfn+0x10/0x10 [dlm]
2024-03-10T21:04:29,482518+00:00  device_write+0x5f1/0x790 [dlm]
2024-03-10T21:04:29,483140+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:29,483672+00:00  ? __x64_sys_fcntl+0x90/0xc0
2024-03-10T21:04:29,484254+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:29,484785+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:29,485380+00:00  ? exc_page_fault+0x73/0x170
2024-03-10T21:04:29,485954+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76

2024-03-10T21:04:30,416950+00:00 dlm: kref_get 1
2024-03-10T21:04:30,417698+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:30,418547+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:30,419629+00:00 Call Trace:
2024-03-10T21:04:30,420115+00:00  <TASK>
2024-03-10T21:04:30,420566+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:30,421157+00:00  find_lkb+0x4e/0xd0 [dlm]
2024-03-10T21:04:30,421758+00:00  dlm_user_unlock+0x6b/0x2f0 [dlm]
2024-03-10T21:04:30,422422+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:30,423140+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:30,423785+00:00  device_write+0x5bd/0x790 [dlm]
2024-03-10T21:04:30,424404+00:00  ? security_file_permission+0x32/0x50
2024-03-10T21:04:30,425057+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:30,425606+00:00  ? syscall_exit_to_user_mode+0x81/0x220
2024-03-10T21:04:30,426268+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,426857+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:30,427415+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:30,427969+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,428534+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,429098+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,429657+00:00  ? __irq_exit_rcu+0x3b/0xb0
2024-03-10T21:04:30,430211+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76

2024-03-10T21:04:30,440429+00:00 dlm: kref_put 1
2024-03-10T21:04:30,441102+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:30,441961+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:30,443065+00:00 Call Trace:
2024-03-10T21:04:30,443571+00:00  <TASK>
2024-03-10T21:04:30,444029+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:30,444618+00:00  _unlock_lock+0x73/0x110 [dlm]
2024-03-10T21:04:30,445257+00:00  unlock_lock.constprop.0+0x55/0x90 [dlm]
2024-03-10T21:04:30,445979+00:00  dlm_user_unlock+0x13b/0x2f0 [dlm]
2024-03-10T21:04:30,446641+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:30,447345+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:30,447979+00:00  device_write+0x5bd/0x790 [dlm]
2024-03-10T21:04:30,448593+00:00  ? security_file_permission+0x32/0x50
2024-03-10T21:04:30,449460+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:30,450394+00:00  ? syscall_exit_to_user_mode+0x81/0x220
2024-03-10T21:04:30,451160+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,451773+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:30,452316+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:30,452894+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,453491+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,454053+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,454621+00:00  ? __irq_exit_rcu+0x3b/0xb0
2024-03-10T21:04:30,455175+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76

2024-03-10T21:04:30,464305+00:00 dlm: kref_put 1
2024-03-10T21:04:30,464804+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:30,465649+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:30,466737+00:00 Call Trace:
2024-03-10T21:04:30,467220+00:00  <TASK>
2024-03-10T21:04:30,467684+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:30,468276+00:00  _unlock_lock+0x9e/0x110 [dlm]
2024-03-10T21:04:30,468912+00:00  unlock_lock.constprop.0+0x55/0x90 [dlm]
2024-03-10T21:04:30,469607+00:00  dlm_user_unlock+0x13b/0x2f0 [dlm]
2024-03-10T21:04:30,470261+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:30,470961+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:30,471611+00:00  device_write+0x5bd/0x790 [dlm]
2024-03-10T21:04:30,472221+00:00  ? security_file_permission+0x32/0x50
2024-03-10T21:04:30,472867+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:30,473397+00:00  ? syscall_exit_to_user_mode+0x81/0x220
2024-03-10T21:04:30,474055+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,474633+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:30,475179+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:30,475759+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,476322+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,476883+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,477442+00:00  ? __irq_exit_rcu+0x3b/0xb0
2024-03-10T21:04:30,478000+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76

2024-03-10T21:04:30,486964+00:00 dlm: kref_get 1
2024-03-10T21:04:30,487460+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:30,488304+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:30,489384+00:00 Call Trace:
2024-03-10T21:04:30,489869+00:00  <TASK>
2024-03-10T21:04:30,490320+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:30,490918+00:00  dlm_user_add_ast+0x1fc/0x300 [dlm]
2024-03-10T21:04:30,491609+00:00  _unlock_lock+0xbe/0x110 [dlm]
2024-03-10T21:04:30,492231+00:00  unlock_lock.constprop.0+0x55/0x90 [dlm]
2024-03-10T21:04:30,492914+00:00  dlm_user_unlock+0x13b/0x2f0 [dlm]
2024-03-10T21:04:30,493553+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:30,494238+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:30,494869+00:00  device_write+0x5bd/0x790 [dlm]
2024-03-10T21:04:30,495479+00:00  ? security_file_permission+0x32/0x50
2024-03-10T21:04:30,496133+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:30,496660+00:00  ? syscall_exit_to_user_mode+0x81/0x220
2024-03-10T21:04:30,497318+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,497898+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:30,498428+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:30,498978+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,499532+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,500086+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,500639+00:00  ? __irq_exit_rcu+0x3b/0xb0
2024-03-10T21:04:30,501192+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76

2024-03-10T21:04:30,510147+00:00 dlm: kref_put 1
2024-03-10T21:04:30,510651+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:30,511482+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:30,512564+00:00 Call Trace:
2024-03-10T21:04:30,513045+00:00  <TASK>
2024-03-10T21:04:30,513496+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:30,514081+00:00  __put_lkb+0x30/0x100 [dlm]
2024-03-10T21:04:30,514683+00:00  dlm_user_add_ast+0x1cc/0x300 [dlm]
2024-03-10T21:04:30,515337+00:00  _unlock_lock+0xbe/0x110 [dlm]
2024-03-10T21:04:30,515953+00:00  unlock_lock.constprop.0+0x55/0x90 [dlm]
2024-03-10T21:04:30,516633+00:00  dlm_user_unlock+0x13b/0x2f0 [dlm]
2024-03-10T21:04:30,517265+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:30,517957+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:30,518586+00:00  device_write+0x5bd/0x790 [dlm]
2024-03-10T21:04:30,519199+00:00  ? security_file_permission+0x32/0x50
2024-03-10T21:04:30,519840+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:30,520365+00:00  ? syscall_exit_to_user_mode+0x81/0x220
2024-03-10T21:04:30,521021+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,521586+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:30,522100+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:30,522654+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,523212+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,523779+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,524333+00:00  ? __irq_exit_rcu+0x3b/0xb0
2024-03-10T21:04:30,524888+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76

2024-03-10T21:04:30,533818+00:00 dlm: kref_put 1
2024-03-10T21:04:30,534317+00:00 CPU: 0 PID: 1562 Comm: fsck.ocfs2 Not tainted 6.8.0-rc7+ #80
2024-03-10T21:04:30,535151+00:00 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
2024-03-10T21:04:30,536247+00:00 Call Trace:
2024-03-10T21:04:30,536729+00:00  <TASK>
2024-03-10T21:04:30,537179+00:00  dump_stack_lvl+0x43/0x60
2024-03-10T21:04:30,537755+00:00  __put_lkb+0x30/0x100 [dlm]
2024-03-10T21:04:30,538355+00:00  dlm_user_unlock+0x213/0x2f0 [dlm]
2024-03-10T21:04:30,539003+00:00  ? __kmalloc_node_track_caller+0x1a9/0x420
2024-03-10T21:04:30,539698+00:00  ? device_write+0x44/0x790 [dlm]
2024-03-10T21:04:30,540319+00:00  device_write+0x5bd/0x790 [dlm]
2024-03-10T21:04:30,540927+00:00  ? security_file_permission+0x32/0x50
2024-03-10T21:04:30,541569+00:00  vfs_write+0xec/0x470
2024-03-10T21:04:30,542093+00:00  ? syscall_exit_to_user_mode+0x81/0x220
2024-03-10T21:04:30,542759+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,543327+00:00  ksys_write+0x6b/0xf0
2024-03-10T21:04:30,543851+00:00  do_syscall_64+0x87/0x1a0
2024-03-10T21:04:30,544395+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,544949+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,545500+00:00  ? do_syscall_64+0x93/0x1a0
2024-03-10T21:04:30,546059+00:00  ? __irq_exit_rcu+0x3b/0xb0
2024-03-10T21:04:30,546621+00:00  entry_SYSCALL_64_after_hwframe+0x6e/0x76
2024-03-10T21:04:30,547274+00:00 RIP: 0033:0x7fa4d45f0ba0

-- 
Valentin
