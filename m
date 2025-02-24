Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203581FCFE2
	for <gfs2@lists.linux.dev>; Mon, 24 Feb 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425716; cv=none; b=Mz4zMSc1TiosMchv5DZeA2VY7yGHThDQ75EjGS8kh+B++5EEe7KZ2KGxYAhwGhpoZacRdP4WIxxjsQs/NFO8lrT83M5ZXqZwyBTesMPGuHpZ/ms3YkIP94uiRuy4k/tf4ZkodEQqL+ysMSMw3mAFF3FwBoc9Z3bYmt+9OOFyp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425716; c=relaxed/simple;
	bh=NlrmC7RjmjTFhLw+Yy0Plx6g4f7rwkg8oH/TScS6OvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EYq2GxBocWWiXoX4FCCT7UBQb2CXMx6HGzvjulWVQTbs+NdgQR482KznRZSVXRBGskN7qGy7jhMtTh2rCwafii6bodgcrxZ50005a3Uft056FzN+9o5k1GVnkaEPtkBnHJScMs+VfeFbkAsZBrkC4XngilD0t45x8rfyQr39C0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yjs6ikb3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yjs6ikb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740425712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlrmC7RjmjTFhLw+Yy0Plx6g4f7rwkg8oH/TScS6OvI=;
	b=Yjs6ikb3M5+WdZfpw7LvvCnsFZl3iBv/CAJpMeZnHMZGiZawvRKW+8YG+tbaO6Eqb3BKnN
	s/EIhC6FZ5k+kH5tXo3xNl3pblyYbGIJYbFewFKybRWOgue+3XL4sR9OjPktyYrLdFa5Aw
	uXydFiuwMFsqaSuj1W0QBju5WZN/3+8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-2hCWaXbEOJi4vuGXTKLciQ-1; Mon,
 24 Feb 2025 14:35:09 -0500
X-MC-Unique: 2hCWaXbEOJi4vuGXTKLciQ-1
X-Mimecast-MFC-AGG-ID: 2hCWaXbEOJi4vuGXTKLciQ_1740425708
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53247180087C;
	Mon, 24 Feb 2025 19:35:08 +0000 (UTC)
Received: from redhat.com (unknown [10.22.64.219])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BD3F180035F;
	Mon, 24 Feb 2025 19:35:06 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:35:04 -0600
From: David Teigland <teigland@redhat.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Heming Zhao <heming.zhao@suse.com>, ccaulfie@redhat.com,
	jfriesse@redhat.com, nicholas.yang@suse.com, glass.su@suse.com,
	gfs2@lists.linux.dev
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel
 DLM_MAX_ADDR_COUNT
Message-ID: <Z7zJ6OQIzC9Q20sG@redhat.com>
References: <20250221150937.21642-1-heming.zhao@suse.com>
 <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K_PvkyNYHwGGo8RCEF7MwkuhZdv1LSbedbPf20oeSUA_1740425708
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2025 at 10:27:04AM -0500, Alexander Aring wrote:
> What are we doing with the detect_protocol() change? You want to
> submit the current version again? I would like to test it with
> corosync 2 vs 3 with no configuration changes on an upgrade (if this
> is even possible).

I suggest we stop trying to detect, and always use tcp unless protocol is
set to sctp.

Dave

