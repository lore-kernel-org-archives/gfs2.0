Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE117EF
	for <gfs2@lists.linux.dev>; Sat, 30 Mar 2024 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711783513; cv=none; b=ejnuWBXNN0lAJyPZqKySj7yBrMeLG65H3YhogXilXQXv+s1DwmctpzDNFj5A6RXJd6n6N41Uw6erEcaS6bwKgq85cWxXEiRSTu6rUoI5rD2MQa9Q+zDUKH9+yi46PP6q2kzKZ7jhT1Tv8NXAM0D5JffbpFFujdr9Ive3Csid+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711783513; c=relaxed/simple;
	bh=2ml+VvnRcec4A3LwHhOolExZ1Df47SRTWchtzfr2/aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SJOYJCdbJmZhuhArnKK++qoHPPB2S6mML8EdDwGAhrbv4o+8MLj/l3Tb2fas+O0Xca5Q1xVEBsz8FHUVMl7ycJ9M5hEOM0gfEMcmod02qS32ZlgtPP+jM8rwAt1cZIa4L9qrBMESv47vdfsHuSbedTdBXzRjf5uL9o446IhoN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zyn/PIIe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zyn/PIIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711783510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEXwxnia+I9FUvVWYy9eqOh+s4AgHAmik8d9pwtzgMw=;
	b=Zyn/PIIeIEc8M7lzMUq7yv5Ehp2Hv00VjrBfmX+Bptk1ZxEO1XIddgjvSy3g6UQiXoYRq1
	aBZO750nXokYpU/xzHsd8sefOgIyormNeJWKVUfVHWIxfJh3piHYB6//+c0XEnJytAqOt1
	ky1NLjkTG4UgbG0FSReBBNFwQBNwpko=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-rZtOhb7FN-aC_iKMIs43yA-1; Sat, 30 Mar 2024 03:25:07 -0400
X-MC-Unique: rZtOhb7FN-aC_iKMIs43yA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e0ac20246bso22817555ad.3
        for <gfs2@lists.linux.dev>; Sat, 30 Mar 2024 00:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711783506; x=1712388306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEXwxnia+I9FUvVWYy9eqOh+s4AgHAmik8d9pwtzgMw=;
        b=oYoTpK4gshFgE8voX8cBHA2Sbi4M1jei6gdBzcSBQE96xlpTMsJzpzIbtbAa8AO6Oi
         FS/1f8KQsYWnIhnD+fVq6NFaoae/yQpnPloCqaRmqVIcIdP1DPIn5ylcN0Fxar4BD8ci
         3xDx0g5PFL5fNWiArDfXaz6lu+e+BsTjQKpqHP3ROln3MGNOMJa3W85vT1kFqMNfqrxd
         BTBJsRomjnqGBy/S5TQiXJgiLhNLJ6zbjDQgzQ3CV/pyGySRcLol2b7uvlpQzjBCmv4j
         W3B47ErF+2rKRcud05hqppMlJHXyZ/hY2ZlpkdMqLVf9mnqsx0QskMmMV/g40O47CU9S
         tYfw==
X-Forwarded-Encrypted: i=1; AJvYcCWNrXHPDv+a1hVvHa/hfiEVNg3OspjgM9TPpduLKS8AID6t1nljtO1OzoXJy8aZVXyX9HVnsrgDLzrLdl8KININkUCXtg==
X-Gm-Message-State: AOJu0YyINWwyiEYxkU90qxw+zI2ldpmEsl5r8VKl4hWISocBXR5hnp2N
	DKNJxzaQnZSsUXl10eBmKtWPWsCqfjy6xMi8VWK6H4sJNh3R/qjgdf8cNf7WbVjPZNXP4JkPnoL
	mUURF38riBGFDZn2RbgH8auuKgARXsq8sCCRq9Hn4OsXSN3ncIGY=
X-Received: by 2002:a17:902:d507:b0:1e0:bd7f:194 with SMTP id b7-20020a170902d50700b001e0bd7f0194mr5420757plg.36.1711783506012;
        Sat, 30 Mar 2024 00:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9/nqrZA4v7SIreT10FRYoN+6f2FC07vSQUZAaDK6VjshuPzbMa+ABfutjB2jt8GmJ5CsMbw==
X-Received: by 2002:a17:902:d507:b0:1e0:bd7f:194 with SMTP id b7-20020a170902d50700b001e0bd7f0194mr5420727plg.36.1711783505497;
        Sat, 30 Mar 2024 00:25:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v12-20020a170902d08c00b001dcfaab3457sm4612478plv.104.2024.03.30.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 00:25:05 -0700 (PDT)
Date: Sat, 30 Mar 2024 15:25:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: fstests@vger.kernel.org, gfs2@lists.linux.dev, jlayton@kernel.org
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
Message-ID: <20240330072500.qs73uzweykk3npsq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230925201827.1703857-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230925201827.1703857-1-aahringo@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 25, 2023 at 04:18:27PM -0400, Alexander Aring wrote:
> This patch adds fcntl corner cases that was being used to confirm issues
> on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> implementation and in those corner cases issues was being found and
> fixed.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
> changes since v2:
> - move fcntl tests into one fcntl c file
> - remove ofd and same owner tests, should be reflected by only one test
> - simplify commit message (remove testname out of it)
> - add error messages in fcntl.c to give more information if an error
>   occur

Any update? :) It's still in "patches-in-queue" branch.

Thanks,
Zorro

> 
>  src/Makefile          |   3 +-
>  src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/732     |  32 +++++
>  tests/generic/732.out |   2 +
>  4 files changed, 358 insertions(+), 1 deletion(-)
>  create mode 100644 src/fcntl.c
>  create mode 100755 tests/generic/732
>  create mode 100644 tests/generic/732.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index 2815f919..67f936d3 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
> +	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> +	fcntl
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/fcntl.c b/src/fcntl.c
> new file mode 100644
> index 00000000..8e375357
> --- /dev/null
> +++ b/src/fcntl.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
> + */
> +
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <wait.h>
> +
> +static char filename[PATH_MAX + 1];
> +static int fd;
> +
> +static void usage(char *name, const char *msg)
> +{
> +	printf("Fatal: %s\nUsage:\n"
> +	       "%s <file for fcntl>\n", msg, name);
> +	_exit(1);
> +}
> +
> +static void *do_equal_file_lock_thread(void *arg)
> +{
> +       struct flock fl = {
> +	       .l_type = F_WRLCK,
> +	       .l_whence = SEEK_SET,
> +	       .l_start = 0L,
> +	       .l_len = 1L,
> +       };
> +       int rv;
> +
> +       rv = fcntl(fd, F_SETLKW, &fl);
> +       if (rv == -1) {
> +	       perror("fcntl");
> +	       _exit(1);
> +       }
> +
> +       return NULL;
> +}
> +
> +static void do_test_equal_file_lock(void)
> +{
> +	struct flock fl;
> +	pthread_t t[2];
> +	int pid, rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0L;
> +	fl.l_len = 1L;
> +
> +	/* acquire range 0-0 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +	       perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		rv = pthread_create(&t[0], NULL, do_equal_file_lock_thread, NULL);
> +		if (rv != 0) {
> +			fprintf(stderr, "failed to create pthread\n");
> +			_exit(1);
> +		}
> +
> +		rv = pthread_create(&t[1], NULL, do_equal_file_lock_thread, NULL);
> +		if (rv != 0) {
> +			fprintf(stderr, "failed to create pthread\n");
> +			_exit(1);
> +		}
> +
> +		pthread_join(t[0], NULL);
> +		pthread_join(t[1], NULL);
> +
> +		_exit(0);
> +	}
> +
> +	/* wait until threads block on 0-0 */
> +	sleep(3);
> +
> +	fl.l_type = F_UNLCK;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	sleep(3);
> +
> +	/* check if the ->lock() implementation got the
> +	 * right locks granted because two waiter with the
> +	 * same file_lock fields are waiting
> +	 */
> +	fl.l_type = F_WRLCK;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1 && errno == EAGAIN) {
> +		fprintf(stderr, "deadlock, pthread not cleaned up correctly\n");
> +		_exit(1);
> +	}
> +
> +	wait(NULL);
> +}
> +
> +static void catch_alarm(int num) { }
> +
> +static void do_test_signal_interrupt_child(int *pfd)
> +{
> +	struct sigaction act;
> +	unsigned char m;
> +	struct flock fl;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 1;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	memset(&act, 0, sizeof(act));
> +	act.sa_handler = catch_alarm;
> +	sigemptyset(&act.sa_mask);
> +	sigaddset(&act.sa_mask, SIGALRM);
> +	sigaction(SIGALRM, &act, NULL);
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* interrupt SETLKW by signal in 3 secs */
> +	alarm(3);
> +	rv = fcntl(fd, F_SETLKW, &fl);
> +	if (rv == 0) {
> +		fprintf(stderr, "fcntl interrupt successful but should fail with EINTR\n");
> +		_exit(1);
> +	}
> +
> +	/* synchronize to move parent to test region 1-1 */
> +	write(pfd[1], &m, sizeof(m));
> +
> +	/* keep child alive */
> +	read(pfd[1], &m, sizeof(m));
> +}
> +
> +static void do_test_signal_interrupt(void)
> +{
> +	struct flock fl;
> +	unsigned char m;
> +	int pid, rv;
> +	int pfd[2];
> +
> +	rv = pipe(pfd);
> +	if (rv == -1) {
> +		perror("pipe");
> +		_exit(1);
> +	}
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		do_test_signal_interrupt_child(pfd);
> +		_exit(0);
> +	}
> +
> +	/* wait until child writes */
> +	read(pfd[0], &m, sizeof(m));
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 1;
> +	fl.l_len = 1;
> +	/* parent testing childs region, the child will think
> +	 * it has region 1-1 locked because it was interrupted
> +	 * by region 0-0. Due bugs the interruption also unlocked
> +	 * region 1-1.
> +	 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == 0) {
> +		fprintf(stderr, "fcntl trylock successful but should fail because child still acquires region\n");
> +		_exit(1);
> +	}
> +
> +	write(pfd[0], &m, sizeof(m));
> +
> +	wait(NULL);
> +
> +	close(pfd[0]);
> +	close(pfd[1]);
> +
> +	/* cleanup everything */
> +	fl.l_type = F_UNLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 2;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +}
> +
> +static void do_test_kill_child(void)
> +{
> +	struct flock fl;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLKW, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +}
> +
> +static void do_test_kill(void)
> +{
> +	struct flock fl;
> +	int pid_to_kill;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid_to_kill = fork();
> +	if (pid_to_kill == 0) {
> +		do_test_kill_child();
> +		_exit(0);
> +	}
> +
> +	/* wait until child blocks */
> +	sleep(3);
> +
> +	kill(pid_to_kill, SIGKILL);
> +
> +	/* wait until Linux did plock cleanup */
> +	sleep(3);
> +
> +	fl.l_type = F_UNLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* cleanup parent lock */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* check if the child still holds the lock
> +	 * and killing the child was not cleaning
> +	 * up locks.
> +	 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if ((rv == -1 && errno == EAGAIN)) {
> +		fprintf(stderr, "fcntl trylock failed but should be successful because killing child should cleanup acquired lock\n");
> +		_exit(1);
> +	}
> +}
> +
> +int main(int argc, char * const argv[])
> +{
> +	if (optind != argc - 1)
> +		usage(argv[0], "<file for fcntl> is mandatory to tell the file where to run fcntl() on it");
> +
> +	strncpy(filename, argv[1], PATH_MAX);
> +
> +	fd = open(filename, O_RDWR | O_CREAT, 0700);
> +	if (fd == -1) {
> +		perror("open");
> +		_exit(1);
> +	}
> +
> +	/* test to have to equal struct file_lock requests in ->lock() */
> +	do_test_equal_file_lock();
> +	/* test to interrupt F_SETLKW by a signal and cleanup only canceled the pending interrupted request */
> +	do_test_signal_interrupt();
> +	/* test if cleanup is correct if a child gets killed while being blocked in F_SETLKW */
> +	do_test_kill();
> +
> +	close(fd);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/732 b/tests/generic/732
> new file mode 100755
> index 00000000..d77f9fc2
> --- /dev/null
> +++ b/tests/generic/732
> @@ -0,0 +1,32 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
> +#
> +# FS QA Test 732
> +#
> +# This tests performs some fcntl() corner cases. See fcntl test
> +# program for more details.
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_test
> +_require_test_program fcntl
> +
> +echo "Silence is golden"
> +
> +$here/src/fcntl $TEST_DIR/testfile
> +if [ $? -ne 0 ]
> +then
> +	exit
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/732.out b/tests/generic/732.out
> new file mode 100644
> index 00000000..451f82ce
> --- /dev/null
> +++ b/tests/generic/732.out
> @@ -0,0 +1,2 @@
> +QA output created by 732
> +Silence is golden
> -- 
> 2.31.1
> 

