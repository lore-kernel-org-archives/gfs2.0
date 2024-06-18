Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A346521
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726724; cv=none; b=tWJ3fqIY2QRKG7WJ5bmVzw7tinOqPT2wZfbSh7vzQR6gy5qE9QS7ZQlIRwwgQw49Amlpjw8KlkmtdiGh1FzMYCp2CzztoAvwZ7khkypnibMPVIhvs3S+mEr1wi15GPKVUnszxWdA/RZYrSMOUJHcgjyORmG5o83bkR+KSnuk9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726724; c=relaxed/simple;
	bh=OpQpt+CnkB1oMwTTLTT5WXLdz/1af+eSFMfu8bhNJBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SZDbCDvzx6fVCvXWbWKNBqK8BSSRcpGOly50954c7vQ/LDgVx0B8QKXo/na2vsaOMj0GHPKuvDNqUoVt8LA5MvQAQ3TzC6waBRbVVjk/6kd6CWBp2H84ziWspM2OXIdW3kShrR8PaqIWeULIGhATvGUYp938AYQ64AVJYLTjMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edY7h4hB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edY7h4hB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KMYUBg1ho3ZvRHWSOFzJgFBe2eH3mpMgYienFWInzGM=;
	b=edY7h4hBw5KMK3WOGD4pptz3zL2/UcBbB0h+/+PcL6XEau6SoFNVgBlhKnKAR2dqqnmLHr
	YbeIIXB5P+FVYDpfGZ4RRql2AvUllUOpwNFgJudgO23fAPSFW51LjawRR91n930lxhfVQ4
	XbSNqXzkGWg/Q8DH4o1Tg852a3YmFTU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-b0JkDFWRPWGunCd8Iz8imw-1; Tue,
 18 Jun 2024 12:05:20 -0400
X-MC-Unique: b0JkDFWRPWGunCd8Iz8imw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A5281956055
	for <gfs2@lists.linux.dev>; Tue, 18 Jun 2024 16:05:20 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11BE419560B2;
	Tue, 18 Jun 2024 16:05:18 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 00/13] gfs2: quota changes
Date: Tue, 18 Jun 2024 18:05:04 +0200
Message-ID: <20240618160517.901589-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We have recently discovered that commit 4c6a08125f22 ("gfs2: ignore
negated quota changes") was causing corruption in "quota_change%u"
files.  A more in-depth review of the quota code has revealed several
more problems, both long-standing and in the quota changes merged last
September.  Here are a number of fixes; please review.

Thanks,
Andreas

Andreas Gruenbacher (13):
  gfs2: Minor gfs2_quota_init error path cleanup
  gfs2: Check quota consistency on mount
  gfs2: Revert "introduce qd_bh_get_or_undo"
  gfs2: qd_check_sync cleanups
  gfs2: Revert "ignore negated quota changes"
  gfs2: Revert "Add quota_change type"
  gfs2: Fix and clean up function do_qc
  gfs2: quota need_sync cleanup
  gfs2: Fold qd_fish into gfs2_quota_sync
  gfs2: Add some missing quota locking
  gfs2: Get rid of some unnecessary quota locking
  gfs2: Be more careful with the quota sync generation
  gfs2: Revert "check for no eligible quota changes"

 fs/gfs2/incore.h     |   1 -
 fs/gfs2/ops_fstype.c |   1 -
 fs/gfs2/quota.c      | 390 ++++++++++++++++++++++---------------------
 fs/gfs2/util.c       |   6 +-
 4 files changed, 205 insertions(+), 193 deletions(-)

-- 
2.45.1

