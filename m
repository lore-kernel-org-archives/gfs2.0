Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE948C8CB
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284846; cv=none; b=RI+vI+Er8KCdOR7hqO+vUHO2nLzTexJrOZT9S/Of+szDqygDNOtCsL31Z0IDiNYSV/Le67UZ87HmECmv6eHSVlga/CIuES+qDdKVP7+AgoQRonIEoiG/rVOv1lig0Htex8S00iYPZLYqa9d9Ji+BgvFPFvPVYz/qPZR7EOtyvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284846; c=relaxed/simple;
	bh=IxULnbe+7ob0V2zxZX/NuSBanYa8NrhEB1iwsI8nzB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZFYsLpgvpllc8Jme2AyrzP0ZmLtXIB6bbUufqUlE3GPB17c06LYtuxHjZxhl9s6TapgD+GqMXOL8xRmlc0AwzSOltjhtqBun1KKAHFF8F1g0ljxph/hQh7BzOkWQeSHt5D7X8Ug4YQ3TTogMnqEEVm8x34X0bnOIuTZX0pSSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv6c0qjj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv6c0qjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788284843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U2Uxz5tGJsJKcCdhcIPDfALQbORSU2QJB+AHEE787GQ=;
	b=dv6c0qjjyK1Lov+Qh0+9HRTG47Kirs1qxIkWGVwB70ziPfMZlTKzw29/3YStPJZuZN4Hi3
	+PuHi/cme/x8oENp0GZXVlUpwei88tfIWzJt+wy4S3t9vpWICsKXRMkFBh85vQkZl8akp0
	/xyiwwdvG0m6ED+wcrviF4JrMbV126k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-4OPggnMyPFuxROeGte0Tkw-1; Tue,
 01 Sept 2026 13:47:22 -0400
X-MC-Unique: 4OPggnMyPFuxROeGte0Tkw-1
X-Mimecast-MFC-AGG-ID: 4OPggnMyPFuxROeGte0Tkw_1788284841
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 292841954B14
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 17:47:21 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 638741803A5D;
	Tue,  1 Sep 2026 17:47:20 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND dlm/next 0/8] dlm: pending fixes based on v7.3-rc1
Date: Tue,  1 Sep 2026 13:47:07 -0400
Message-ID: <20260901174715.3825582-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XJE_JdINdohB7BrAdq7vauD405vLp6PieUgsGyFT5oY_1788284841
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

this patch series contains pending fixed for dlm.

Some critical to be ensure that monitor/plock chardevs are only be
opened under administrator rights which should be as e.g. dlm_controld
is using them running as root and can conflict with additional multiple
usages. To forbid any misusage we forbid to open those devices for
normal users.

Then we switch back to rhashtables to dynamic key lengths as this might
get conflicts for DLM users who actually using different resource name
lengths in DLM.

Additional malformed packets drops to avoid kernel crashes, however we
still cannot recover from those drops but this is another problem.

Then there are missing barriers for srcu as call_srcu() uses the srcu
static structures which can end in an use after free when the module is
removed.

- Alex

Alexander Aring (1):
  dlm: fix variable key length lookup

Danila Chernetsov (2):
  dlm: validate lock modes in recovery messages
  dlm: fix NULL pointer dereference in dlm_dump_rsb_name()

Haofeng Li (2):
  dlm: gate dlm_plock device on CAP_SYS_ADMIN
  dlm: require CAP_SYS_ADMIN for dlm-monitor device

Joseph Qi (1):
  dlm: fix buffer overflow from negative len in dlm_search_rsb_tree

Samuel Moelius (1):
  dlm: validate userspace lock resource name length

Zqiang (1):
  dlm: wait for outstanding SRCU callbacks to complete in exit paths

 fs/dlm/config.c       | 30 ++++++++++++++++++++++++++++--
 fs/dlm/dlm_internal.h |  5 +++++
 fs/dlm/lock.c         | 18 +++++++++++++-----
 fs/dlm/lock.h         |  4 ++--
 fs/dlm/lowcomms.c     |  1 +
 fs/dlm/midcomms.c     |  1 +
 fs/dlm/plock.c        | 14 +++++++++++++-
 fs/dlm/user.c         | 23 +++++++++++++++++++++++
 8 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.43.0

